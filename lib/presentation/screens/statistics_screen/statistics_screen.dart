import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';
import 'package:mood_tracker_2/presentation/screens/statistics_screen/statistics_screen_body.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ActivitiesBloc>()
            ..add(const InitActivitiesBlocEvent(
              isCreate: false,
              originalMood: Mood.mediocre,
            )),
        ),
        BlocProvider(
          create: (context) => getIt<FoodsBloc>()
            ..add(const InitFoodsBlocEvent(
              isCreate: false,
              originalMood: Mood.mediocre,
            )),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text('statistics').tr(),
        ),
        body: BlocBuilder<ActivitiesBloc, ActivitiesState>(
          builder: (context, actState) {
            return BlocBuilder<FoodsBloc, FoodsState>(
              builder: (context, foodState) {
                if (actState.activities.isNotEmpty &&
                    foodState.foods.isNotEmpty) {
                  return const StatisticsScreenBody();
                }

                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
