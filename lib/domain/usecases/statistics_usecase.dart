import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/repository/statistics_repository.dart';

class StatisticsUsecase {
  final StatisticsRepository repository;

  StatisticsUsecase(this.repository);

  Future<List<ActivityEntity>> getAllActivities() async {
    return repository.getAllActivities();
  }

  Future<List<FoodEntity>> getAllFoods() async {
    return repository.getAllFoods();
  }

  Future<void> addActivity(ActivityEntity activity) async {
    return repository.addActivity(activity);
  }

  Future<void> addFood(FoodEntity food) async {
    return repository.addFood(food);
  }

  Future<void> updateActivitiesRatings(List<ActivityEntity> activities) async {
    return repository.updateActivitiesRatings(activities);
  }

  Future<void> updateFoodRatings(List<FoodEntity> foods) async {
    return repository.updateFoodRatings(foods);
  }

  Future<void> updateActivityName(String id, String name) async {
    return repository.updateActivityName(id, name);
  }

  Future<void> updateFoodName(String id, String name) async {
    return repository.updateFoodName(id, name);
  }

  Future<void> deleteActivity(String id) async {
    return repository.deleteActivity(id);
  }

  Future<void> deleteFood(String id) async {
    return repository.deleteFood(id);
  }
}
