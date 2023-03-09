import 'dart:convert';
import 'dart:math';

import 'package:mood_tracker_2/data/models/activity_model.dart';
import 'package:mood_tracker_2/data/models/food_model.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class DayModel extends DayEntity {
  const DayModel({
    required String id,
    required DateTime date,
    required Mood mood,
    List<FoodModel> foods = const [],
    List<ActivityModel> activities = const [],
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
      'foods': foods.map(
        (e) => FoodModel.fromEntity(e).toJson(),
      ),
      'activities': activities.map(
        (e) => ActivityModel.fromEntity(e).toJson(),
      ),
      'goodStuff': goodStuff,
      'badStuff': badStuff,
    });
  }

  factory DayModel.fromJson(Map<String, dynamic> json) {
    final foods = <FoodModel>[];
    final activities = <ActivityModel>[];

    if (json['foods'] != null) {
      for (var food in json['foods']) {
        foods.add(FoodModel.fromJson(food));
      }
    }

    if (json['activities'] != null) {
      for (var activity in json['activities']) {
        activities.add(ActivityModel.fromJson(activity));
      }
    }

    return DayModel(
      id: json['id'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      mood: Mood.values[json['mood']],
      foods: foods,
      activities: activities,
      goodStuff: json['goodStuff'],
      badStuff: json['badStuff'],
    );
  }

  factory DayModel.fromEntity(DayEntity entity) {
    return DayModel(
      id: entity.id,
      date: entity.date,
      mood: entity.mood,
      foods: entity.foods.map((e) => FoodModel.fromEntity(e)).toList(),
      activities:
          entity.activities.map((e) => ActivityModel.fromEntity(e)).toList(),
      goodStuff: entity.goodStuff,
      badStuff: entity.badStuff,
    );
  }

  @override
  List<Object?> get props => [id, date, mood, foods, activities];
}
