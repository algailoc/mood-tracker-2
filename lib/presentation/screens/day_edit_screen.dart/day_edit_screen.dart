import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';

class DayEditScreen extends StatelessWidget {
  final DayScreenParams params;

  const DayEditScreen(this.params, {super.key});

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
                InitActivitiesBlocEvent(
                  isCreate: false,
                  originalMood: params.day?.mood ?? Mood.mediocre,
                  day: params.day,
                ),
              )),
        BlocProvider<FoodsBloc>(
          create: (context) => getIt<FoodsBloc>()
            ..add(
              InitFoodsBlocEvent(
                isCreate: false,
                originalMood: Mood.mediocre,
                day: params.day,
              ),
            ),
        ),
      ],
      child: BlocBuilder<DayBloc, DayState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            title: Text(
              params.day == null
                  ? 'newDay'.tr()
                  : DateFormat('DD.MM.yyyy').format(params.day!.date),
            ),
          ),
          body: const _ScreenBody(),
        ),
      ),
    );
  }
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
