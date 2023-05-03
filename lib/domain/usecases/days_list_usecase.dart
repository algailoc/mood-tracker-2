import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/repository/days_repository.dart';

class DaysListUsecase {
  final DaysRepository repository;

  DaysListUsecase(this.repository);

  Future<List<DayEntity>> getDaysList() async {
    try {
      return repository.getAllDays();
    } catch (e) {
      debugPrint('Error on getting days: $e');
      return [];
    }
  }
}
