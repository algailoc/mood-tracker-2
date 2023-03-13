import 'package:mood_tracker_2/data/datasources/settings_local_datasource.dart';
import 'package:mood_tracker_2/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isLastFilledDayToday() {
    return localDataSource.isLastFilledDayToday();
  }

  @override
  Future<void> setLastFilledDay(DateTime date) {
    return localDataSource.setLastFilledDay(date);
  }
}
