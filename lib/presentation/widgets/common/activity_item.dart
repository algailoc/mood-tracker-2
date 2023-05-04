import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';

class ActivityItem extends StatelessWidget {
  final ActivityEntity activity;
  final void Function()? onActivityPressed;
  final void Function()? onActivityLongPressed;
  final bool isSelected;

  const ActivityItem({
    super.key,
    required this.activity,
    this.onActivityPressed,
    this.onActivityLongPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 3,
      ),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.onSecondary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          splashColor: Theme.of(context).colorScheme.primary,
          onLongPress: onActivityLongPressed,
          onTap: onActivityPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: Text(activity.name),
          ),
        ),
      ),
    );
  }
}
