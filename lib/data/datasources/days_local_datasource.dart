import 'dart:convert';

import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/core/mock/mock_days.dart';
import 'package:mood_tracker_2/data/models/day_model.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class DaysLocalDataSource {
  Future<DayEntity> addDay(DayEntity day);
  Future<void> updateDay(DayEntity day);

  Future<List<DayEntity>> getAllDays();
  Future<DayEntity> getDay(String id);
}

class DaysLocalDataSourceImpl implements DaysLocalDataSource {
  final box = Hive.box(daysBoxName);

  @override
  Future<DayEntity> addDay(DayEntity day) async {
    var id = const Uuid().v4();

    // Checking that id is unique
    while ((await box.get(id)) != null) {
      id = const Uuid().v4();
    }

    await box.put(day.id, DayModel.fromEntity(day).toJson());

    return day.copyWith(id: id);
  }

  @override
  Future<List<DayEntity>> getAllDays() async {
    final data = box.values.toList();

    final result = data.map((e) {
      final json = jsonDecode(e);
      return DayModel.fromJson(json);
    }).toList();

    result.addAll(mockDays);

    result.sort((a, b) => b.date.compareTo(a.date));

    return result;
  }

  @override
  Future<DayEntity> getDay(String id) async {
    final data = await box.get(id);

    return DayModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> updateDay(DayEntity day) {
    return box.put(day.id, DayModel.fromEntity(day).toJson());
  }
}
