import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

IconData getMoodIcon(Mood mood) {
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

Color getMoodColor(Mood mood) {
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
