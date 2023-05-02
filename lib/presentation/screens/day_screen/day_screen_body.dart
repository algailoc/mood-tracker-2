import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_activities_list.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_foods_list.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/mood_component.dart';

class DayScreenBody extends StatelessWidget {
  const DayScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(builder: (context, state) {
      final day = state.dayEntity!;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ListView(
          children: [
            DayMoodComponent(day.mood),
            const SizedBox(height: 20),
            if (day.activities.isNotEmpty) ...[
              DayActivitiesList(day.activities),
              const SizedBox(height: 20),
            ],
            if (day.foods.isNotEmpty) ...[
              DayFoodsList(day.foods),
              const SizedBox(height: 20),
            ],
          ],
        ),
      );
    });
  }
}
