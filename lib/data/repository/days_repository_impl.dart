import 'package:mood_tracker_2/data/datasources/days_local_datasource.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/repository/days_repository.dart';

class DaysRepositoryImpl implements DaysRepository {
  final DaysLocalDataSource localDataSource;

  DaysRepositoryImpl(this.localDataSource);

  @override
  Future<void> addDay(DayEntity day) {
    return localDataSource.addDay(day);
  }

  @override
  Future<List<DayEntity>> getAllDays() {
    return localDataSource.getAllDays();
  }

  @override
  Future<DayEntity> getDay(String id) {
    return localDataSource.getDay(id);
  }

  @override
  Future<void> updateDay(DayEntity day) {
    return localDataSource.updateDay(day);
  }
}
