import 'dart:convert';

import 'package:mood_tracker_2/core/constants.dart';
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
    print('ADDING DAY 2 $day');
    print(day.activities);
    print(day.foods);
    print(day.goodStuff);
    print(day.badStuff);
    var id = const Uuid().v4();

    // Checking that id is unique
    while ((await box.get(id)) != null) {
      id = const Uuid().v4();
    }

    await box.put(id, DayModel.fromEntity(day.copyWith(id: id)).toJson());

    return day.copyWith(id: id);
  }

  @override
  Future<List<DayEntity>> getAllDays() async {
    final data = box.values.toList();

    final result = data.map((e) {
      final json = jsonDecode(e);
      return DayModel.fromJson(json);
    }).toList();

    result.sort((a, b) => b.date.compareTo(a.date));

    return result;
  }

  @override
  Future<DayEntity> getDay(String id) async {
    print('$id');
    final data = await box.get(id);

    return DayModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> updateDay(DayEntity day) {
    return box.put(day.id, DayModel.fromEntity(day).toJson());
  }
}
