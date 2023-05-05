import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/separator.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_activities_list.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_bad_stuff_component.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_description_component.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_foods_list.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/day_good_stuff_component.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/mood_component.dart';

class DayScreenBody extends StatelessWidget {
  const DayScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(builder: (context, state) {
      final day = state.dayEntity!;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBoxSeparator(),
            DayMoodComponent(day.mood),
            const SizedBoxSeparator(),
            if (day.activities.isNotEmpty) ...[
              DayActivitiesList(day.activities),
              const SizedBoxSeparator(),
            ],
            if (day.foods.isNotEmpty) ...[
              DayFoodsList(day.foods),
              const SizedBoxSeparator(),
            ],
            if (day.goodStuff.isNotEmpty) ...[
              DayGoodStuffComponent(day.goodStuff),
              const SizedBoxSeparator(),
            ],
            if (day.badStuff.isNotEmpty) ...[
              DayBadStuffComponent(day.badStuff),
              const SizedBoxSeparator(),
            ],
            if (day.description != null && day.description!.isNotEmpty)
              DayDescriptionComponent(day.description!),
            const SizedBoxSeparator(),
          ],
        ),
      );
    });
  }
}
