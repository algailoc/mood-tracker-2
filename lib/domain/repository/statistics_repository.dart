import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';

abstract class StatisticsRepository {
  Future<List<ActivityEntity>> getAllActivities();
  Future<List<FoodEntity>> getAllFoods();

  Future<void> addActivity(ActivityEntity activity);
  Future<void> addFood(FoodEntity food);

  Future<void> updateActivitiesRatings(List<ActivityEntity> activities);
  Future<void> updateFoodRatings(List<FoodEntity> foods);

  Future<void> updateActivityName(String id, String name);
  Future<void> updateFoodName(String id, String name);

  Future<void> deleteActivity(String id);
  Future<void> deleteFood(String id);
}
