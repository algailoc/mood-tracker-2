import 'package:hive/hive.dart';
import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/data/models/activity_model.dart';
import 'package:mood_tracker_2/data/models/food_model.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';

abstract class StatisticsLocalDataSource {
  Future<void> addActivities(ActivityEntity activity);
  Future<void> addFood(FoodEntity food);

  Future<void> updateActivities(List<ActivityEntity> activities);
  Future<void> updateFood(List<FoodEntity> foods);
}

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final foodsBox = Hive.box(foodsBoxName);
  final activitiesBox = Hive.box(activitiesBoxName);

  @override
  Future<void> updateActivities(List<ActivityEntity> activities) {
    final map = {};

    for (var activity in activities) {
      map.addAll({activity.id: ActivityModel.fromEntity(activity).toJson()});
    }

    return activitiesBox.putAll(map);
  }

  @override
  Future<void> updateFood(List<FoodEntity> foods) {
    final map = {};

    for (var food in foods) {
      map.addAll({food.id: FoodModel.fromEntity(food).toJson()});
    }

    return foodsBox.putAll(map);
  }

  @override
  Future<void> addActivities(ActivityEntity activity) {
    return activitiesBox.put(
      activity.id,
      ActivityModel.fromEntity(activity.copyWith(original: false)).toJson(),
    );
  }

  @override
  Future<void> addFood(FoodEntity food) {
    return foodsBox.put(
      food.id,
      FoodModel.fromEntity(food.copyWith(original: false)).toJson(),
    );
  }
}
