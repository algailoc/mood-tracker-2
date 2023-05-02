import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayMoodComponent extends StatelessWidget {
  final Mood mood;

  const DayMoodComponent(this.mood, {super.key});

  IconData _getMoodIcon() {
    switch (mood) {
      case Mood.awful:
        return Icons.sentiment_very_dissatisfied_outlined;
      case Mood.bad:
        return Icons.sentiment_dissatisfied_outlined;
      case Mood.mediocre:
        return Icons.sentiment_neutral_outlined;
      case Mood.good:
        return Icons.sentiment_satisfied_rounded;
      case Mood.great:
        return Icons.sentiment_very_satisfied_outlined;

      default:
        return Icons.sentiment_neutral_outlined;
    }
  }

  Color _getTextColor() {
    switch (mood) {
      case Mood.awful:
        return Colors.red.shade900;
      case Mood.bad:
        return Colors.red;
      case Mood.mediocre:
        return Colors.grey.shade700;
      case Mood.good:
        return Colors.green.shade400;
      case Mood.great:
        return Colors.green.shade800;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySegmentTitle('mood'),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(
              _getMoodIcon(),
              color: _getTextColor(),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              mood.name,
              style: TextStyle(
                color: _getTextColor(),
              ),
            ).tr(gender: 'neut'),
          ],
        )
      ],
    );
  }
}
