import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/helpers/statistics.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/statistics_screen/mood_component.dart';

class StatisticsScreenBody extends StatefulWidget {
  const StatisticsScreenBody({super.key});

  @override
  State<StatisticsScreenBody> createState() => _StatisticsScreenBodyState();
}

const Map<Mood, List<ActivityEntity>> _initActMap = {
  Mood.great: [],
  Mood.good: [],
  Mood.mediocre: [],
  Mood.bad: [],
  Mood.awful: [],
};

const Map<Mood, List<FoodEntity>> _initFoodMap = {
  Mood.great: [],
  Mood.good: [],
  Mood.mediocre: [],
  Mood.bad: [],
  Mood.awful: [],
};

class _StatisticsScreenBodyState extends State<StatisticsScreenBody> {
  Map<Mood, List<ActivityEntity>> sortedActivities = _initActMap;
  Map<Mood, List<FoodEntity>> sortedFoods = _initFoodMap;

  @override
  void initState() {
    sortedActivities = sortActivitiesByMood(
      BlocProvider.of<ActivitiesBloc>(context).activities,
    );
    sortedFoods = sortFoodsByMood(
      BlocProvider.of<FoodsBloc>(context).foods,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const _SeparatorBox(),
        ...List.generate(Mood.values.length, (index) {
          final mood = Mood.values.reversed.toList()[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoodComponent(
                mood: mood,
                activities: sortedActivities[mood]!,
                foods: sortedFoods[mood]!,
              ),
              const _SeparatorBox(),
            ],
          );
        })
      ],
    );
  }
}

class _SeparatorBox extends StatelessWidget {
  const _SeparatorBox();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}
