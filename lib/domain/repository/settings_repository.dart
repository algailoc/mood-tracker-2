abstract class SettingsRepository {
  Future<void> setLastFilledDay(DateTime date);
  Future<bool> isLastFilledDayToday();
}
