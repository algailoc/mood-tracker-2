import 'package:mood_tracker_2/domain/entities/day_entity.dart';

abstract class DaysRepository {
  Future<void> addDay(DayEntity day);
  Future<void> updateDay(DayEntity day);

  Future<List<DayEntity>> getAllDays();
  Future<DayEntity> getDay(String id);
}
