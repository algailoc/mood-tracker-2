import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mood_tracker_2/core/helpers/confirm_dialog.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';

class DayEditScreen extends StatelessWidget {
  final DayScreenParams params;

  const DayEditScreen(this.params, {super.key});

  void _onSavePressed(BuildContext context) {
    BlocProvider.of<ActivitiesBloc>(context).add(ActivitiesSaveDayEvent());
    BlocProvider.of<FoodsBloc>(context).add(FoodsSaveDayEvent());
    BlocProvider.of<DayBloc>(context).add(SaveDayEvent());
  }

  void _dayBlocListener(BuildContext context, DayState state) {
    if (state is DayAddSuccess) {
      Navigator.of(context).pop(state.dayEntity);
    } else if (state is DayAddError) {
      SmartDialog.showToast('errorOnSavingDay'.tr());
    }
  }

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
      child: BlocConsumer<DayBloc, DayState>(
        listener: _dayBlocListener,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                if (await showConfirmDialog()) {
                  if (context.mounted) Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            title: Text(
              params.day == null
                  ? 'newDay'.tr()
                  : DateFormat('DD.MM.yyyy').format(params.day!.date),
            ),
            actions: [
              TextButton(
                onPressed: () => _onSavePressed(context),
                child: const Text(
                  'save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ).tr(),
              ),
            ],
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
