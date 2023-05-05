import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/repository/days_repository.dart';

class DayUsecase {
  final DaysRepository repository;

  DayUsecase(this.repository);

  Future<DayEntity> addDay(DayEntity day) {
    return repository.addDay(day);
  }

  Future<void> updateDay(DayEntity day) {
    return repository.updateDay(day);
  }

  Future<DayEntity> getDay(String id) {
    return repository.getDay(id);
  }
}
