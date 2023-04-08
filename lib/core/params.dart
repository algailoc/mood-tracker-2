import 'package:mood_tracker_2/domain/entities/day_entity.dart';

class DayScreenParams {
  final DayEntity? day;
  final DateTime dateTime;

  DayScreenParams({this.day, required this.dateTime});
}
