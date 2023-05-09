import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/presentation/widgets/common/activity_item.dart';
import 'package:mood_tracker_2/presentation/widgets/common/food_item.dart';

class MoodComponent extends StatelessWidget {
  final Mood mood;
  final List<ActivityEntity> activities;
  final List<FoodEntity> foods;

  const MoodComponent({
    required this.mood,
    required this.activities,
    required this.foods,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '${mood.name.tr(gender: 'neut')} ${'mood'.tr().toLowerCase()}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '${'activities'.tr()}: ${activities.isEmpty ? 'stillEmpty'.tr() : ''}',
          ),
        ),
        Wrap(
          children: List.generate(activities.length, (index) {
            if (index > 9) return const SizedBox.shrink();
            final activity = activities[index];

            return ActivityItem(
              activity: activity,
              isSelected: false,
            );
          }),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            '${'foods'.tr()}: ${foods.isEmpty ? 'stillEmpty'.tr() : ''}',
          ),
        ),
        Wrap(
          children: List.generate(foods.length, (index) {
            if (index > 9) return const SizedBox.shrink();
            final food = foods[index];

            return FoodItem(
              food: food,
              isSelected: false,
            );
          }),
        ),
      ],
    );
  }
}
