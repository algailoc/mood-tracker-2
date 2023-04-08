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
    String? description,
  }) : super(
          id: id,
          date: date,
          mood: mood,
          foods: foods,
          activities: activities,
          goodStuff: goodStuff,
          badStuff: badStuff,
          description: description,
        );

  String toJson() {
    final dateWithoutTime = DateTime(date.year, date.month, date.day);

    return jsonEncode({
      'id': id,
      'date': dateWithoutTime.millisecondsSinceEpoch,
      'mood': mood.name,
      'foods': foods,
      'activities': activities,
      'goodStuff': goodStuff,
      'badStuff': badStuff,
      'description': description,
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
      description: json['description'],
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
      description: entity.description,
    );
  }

  @override
  List<Object?> get props => [id, date, mood, foods, activities, description];
}
