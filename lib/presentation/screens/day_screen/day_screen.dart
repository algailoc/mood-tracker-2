import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';
import 'package:mood_tracker_2/presentation/screens/day_screen/day_screen_body.dart';

class DayScreen extends StatelessWidget {
  final DayScreenParams params;

  const DayScreen({required this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DayBloc>(
          create: (context) => getIt<DayBloc>()
            ..add(
              InitDayEvent(
                date: params.day?.date ?? params.dateTime,
                day: params.day,
              ),
            ),
        ),
        BlocProvider<ActivitiesBloc>(
          create: (context) => getIt<ActivitiesBloc>()
            ..add(
              const InitActivitiesBlocEvent(
                isCreate: false,
                originalMood: Mood.mediocre,
              ),
            ),
        ),
        BlocProvider<FoodsBloc>(
          create: (context) => getIt<FoodsBloc>()
            ..add(
              const InitFoodsBlocEvent(
                isCreate: false,
                originalMood: Mood.mediocre,
              ),
            ),
        ),
      ],
      child: BlocBuilder<DayBloc, DayState>(
        builder: (context, state) => const _ScreenBody(),
      ),
    );
  }
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody();

  void navigateToEditScreen(BuildContext context, DayEntity day) async {
    final dayBloc = BlocProvider.of<DayBloc>(context);
    final activitiesBloc = BlocProvider.of<ActivitiesBloc>(context);
    final foodsBloc = BlocProvider.of<FoodsBloc>(context);

    final newDay = await Navigator.of(context).pushNamed(
      routeEditDayScreen,
      arguments: DayScreenParams(
        dateTime: dayBloc.day.date,
        day: dayBloc.day,
      ),
    );

    if (newDay != null && newDay is DayEntity) {
      dayBloc.add(InitDayEvent(
        date: day.date,
        day: newDay,
      ));

      activitiesBloc.add(
        InitActivitiesBlocEvent(
          isCreate: false,
          originalMood: newDay.mood,
          day: newDay,
        ),
      );

      foodsBloc.add(
        InitFoodsBlocEvent(
          isCreate: false,
          originalMood: newDay.mood,
          day: newDay,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(builder: (context, state) {
      if (state.dayEntity == null) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final day = state.dayEntity!;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            DateFormat('DD.MM.yyyy').format(day.date),
          ),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => navigateToEditScreen(
                context,
                day,
              ),
              icon: const Icon(
                Icons.mode_edit_outline_outlined,
              ),
            ),
          ],
        ),
        body: const DayScreenBody(),
      );
    });
  }
}
