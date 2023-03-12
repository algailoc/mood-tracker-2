import 'package:mood_tracker_2/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> setLastFilledDay(DateTime date);

  Future<bool> isLastFilledDayToday();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  @override
  Future<bool> isLastFilledDayToday() async {
    final prefs = await SharedPreferences.getInstance();

    var timestamp = 0;

    try {
      timestamp = prefs.getInt(lastFilledDayKey) ?? 0;
    } catch (_) {}

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final today = DateTime.now();

    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  @override
  Future<void> setLastFilledDay(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(lastFilledDayKey, date.millisecondsSinceEpoch);
  }
}
