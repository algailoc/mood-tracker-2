import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';

abstract class StatisticsRepository {
  Future<void> addActivity(ActivityEntity activity);
  Future<void> addFood(FoodEntity food);

  Future<void> updateActivities(List<ActivityEntity> activities);
  Future<void> updateFood(List<FoodEntity> foods);

  Future<void> deleteActivity(String id);
  Future<void> deleteFood(String id);
}
