import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class DayModel extends DayEntity {
  const DayModel({
    required super.id,
    required super.date,
    required super.mood,
    super.foods,
    super.activities,
    super.goodStuff,
    super.badStuff,
    super.description,
  });

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
      mood: Mood.values.byName(json['mood']),
      foods: List<String>.from(json['foods']),
      activities: List<String>.from(json['activities']),
      goodStuff: List<String>.from(json['goodStuff']),
      badStuff: List<String>.from(json['badStuff']),
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
