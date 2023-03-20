import 'package:mood_tracker_2/data/models/day_model.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

final mockDays = [
  DayModel(
    id: '1',
    date: DateTime(2023, 1, 1),
    mood: Mood.bad,
  ),
  DayModel(
    id: '2',
    date: DateTime(2023, 1, 2),
    mood: Mood.great,
  ),
  DayModel(
    id: '3',
    date: DateTime(2023, 1, 3),
    mood: Mood.good,
  ),
  DayModel(
    id: '4',
    date: DateTime(2023, 1, 4),
    mood: Mood.awful,
  ),
  DayModel(
    id: '5',
    date: DateTime(2023, 1, 5),
    mood: Mood.mediocre,
  ),
];
