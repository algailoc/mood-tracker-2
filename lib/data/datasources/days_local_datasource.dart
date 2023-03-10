import 'dart:convert';

import 'package:mood_tracker_2/data/models/day_model.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:hive/hive.dart';

abstract class DaysLocalDataSource {
  Future<void> addDay(DayEntity day);
  Future<void> updateDay(DayEntity day);

  Future<List<DayEntity>> getAllDays();
  Future<DayEntity> getDay(String id);
}

class DaysLocalDataSourceImpl implements DaysLocalDataSource {
  final box = Hive.box('days_box');

  @override
  Future<void> addDay(DayEntity day) {
    return box.put(day.id, DayModel.fromEntity(day).toJson());
  }

  @override
  Future<List<DayEntity>> getAllDays() async {
    final data = box.values.toList();

    return data.map((e) {
      final json = jsonDecode(e);
      return DayModel.fromJson(json);
    }).toList();
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
