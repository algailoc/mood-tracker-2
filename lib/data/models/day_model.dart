import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class DayModel extends DayEntity {
  const DayModel({
    required String id,
    required DateTime date,
    required Mood mood,
    List<String> foods = const [],
    List<String> activities = const [],
    List<String> goodStuff = const [],
    List<String> badStuff = const [],
  }) : super(
          id: id,
          date: date,
          mood: mood,
          foods: foods,
          activities: activities,
          goodStuff: goodStuff,
          badStuff: badStuff,
        );

  String toJson() {
    return jsonEncode({
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'mood': mood.name,
      'foods': foods,
      'activities': activities,
      'goodStuff': goodStuff,
      'badStuff': badStuff,
    });
  }

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      id: json['id'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      mood: Mood.values[json['mood']],
      foods: json['foods'],
      activities: json['activities'],
      goodStuff: json['goodStuff'],
      badStuff: json['badStuff'],
    );
  }

  factory DayModel.fromEntity(DayEntity entity) {
    return DayModel(
      id: entity.id,
      date: entity.date,
      mood: entity.mood,
      foods: entity.foods,
      activities: entity.activities,
      goodStuff: entity.goodStuff,
      badStuff: entity.badStuff,
    );
  }

  @override
  List<Object?> get props => [id, date, mood, foods, activities];
}
