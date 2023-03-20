import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/repository/days_repository.dart';

class DaysListUsecase {
  final DaysRepository repository;

  DaysListUsecase(this.repository);

  Future<List<DayEntity>> getDaysList() {
    return repository.getAllDays();
  }

  Future<void> addDay(DayEntity day) async {}
}
