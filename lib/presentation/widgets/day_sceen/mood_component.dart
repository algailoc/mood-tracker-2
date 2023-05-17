import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/core/helpers/mood_helpers.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayMoodComponent extends StatelessWidget {
  final Mood mood;

  const DayMoodComponent(this.mood, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySegmentTitle('mood'),
        Row(
          children: [
            Icon(
              getMoodIcon(mood),
              color: getMoodColor(mood),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              mood.name,
              style: TextStyle(
                color: getMoodColor(mood),
              ),
            ).tr(gender: 'neut'),
          ],
        )
      ],
    );
  }
}
