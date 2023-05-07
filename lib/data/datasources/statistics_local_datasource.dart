import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/data/models/activity_model.dart';
import 'package:mood_tracker_2/data/models/food_model.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:uuid/uuid.dart';

abstract class StatisticsLocalDataSource {
  Future<List<ActivityEntity>> getAllActivities();
  Future<List<FoodEntity>> getAllFoods();

  Future<ActivityEntity> addActivity(String activity);
  Future<FoodEntity> addFood(String food);

  Future<void> updateActivitiesRating(List<ActivityEntity> activities);
  Future<void> updateFoodRating(List<FoodEntity> foods);

  Future<void> updateActivityName(String id, String name);
  Future<void> updateFoodName(String id, String name);

  Future<void> deleteActivity(String id);
  Future<void> deleteFood(String id);
}

const _initialRating = {
  Mood.awful: 0,
  Mood.bad: 0,
  Mood.mediocre: 0,
  Mood.good: 0,
  Mood.great: 0,
};

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final foodsBox = Hive.box(foodsBoxName);
  final activitiesBox = Hive.box(activitiesBoxName);

  @override
  Future<void> updateActivitiesRating(List<ActivityEntity> activities) {
    final map = {};

    for (var activity in activities) {
      map.addAll({activity.id: ActivityModel.fromEntity(activity).toJson()});
    }

    return activitiesBox.putAll(map);
  }

  @override
  Future<void> updateFoodRating(List<FoodEntity> foods) {
    final map = {};

    for (var food in foods) {
      map.addAll({food.id: FoodModel.fromEntity(food).toJson()});
    }

    return foodsBox.putAll(map);
  }

  @override
  Future<ActivityEntity> addActivity(String activity) async {
    var id = const Uuid().v4();

    // Checking that id is unique
    while ((await activitiesBox.get(id)) != null) {
      id = const Uuid().v4();
    }

    final activityEntity = ActivityEntity(
      id: id,
      name: activity,
      rating: _initialRating,
    );

    await activitiesBox.put(
      id,
      ActivityModel.fromEntity(activityEntity).toJson(),
    );

    return activityEntity;
  }

  @override
  Future<FoodEntity> addFood(String food) async {
    var id = const Uuid().v4();

    // Checking that id is unique
    while ((await foodsBox.get(id)) != null) {
      id = const Uuid().v4();
    }

    final foodEntity = FoodEntity(
      id: id,
      name: food,
      rating: _initialRating,
    );

    await foodsBox.put(
      id,
      FoodModel.fromEntity(foodEntity).toJson(),
    );

    return foodEntity;
  }

  @override
  Future<void> deleteActivity(String id) {
    return activitiesBox.delete(id);
  }

  @override
  Future<void> deleteFood(String id) {
    return foodsBox.delete(id);
  }

  @override
  Future<void> updateActivityName(String id, String name) async {
    final oldJson = await activitiesBox.get(id);
    final oldActivity = ActivityModel.fromJson(jsonDecode(oldJson));
    final newActivity =
        ActivityModel.fromEntity(oldActivity.copyWith(name: name));
    return activitiesBox.put(id, newActivity.toJson());
  }

  @override
  Future<void> updateFoodName(String id, String name) async {
    final oldJson = await foodsBox.get(id);
    final oldFood = FoodModel.fromJson(jsonDecode(oldJson));
    final newFood = FoodModel.fromEntity(oldFood.copyWith(name: name));
    return foodsBox.put(id, newFood.toJson());
  }

  @override
  Future<List<ActivityEntity>> getAllActivities() async {
    final activitiesList = activitiesBox.values.toList();
    final result = <ActivityEntity>[];
    for (var json in activitiesList) {
      result.add(ActivityModel.fromJson(jsonDecode(json)));
    }

    return result;
  }

  @override
  Future<List<FoodEntity>> getAllFoods() async {
    final foodsList = foodsBox.values.toList();
    final result = <FoodEntity>[];
    for (var json in foodsList) {
      result.add(FoodModel.fromJson(jsonDecode(json)));
    }

    return result;
  }
}
