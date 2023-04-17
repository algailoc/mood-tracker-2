import 'package:mood_tracker_2/data/datasources/statistics_local_datasource.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/repository/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsLocalDataSource localDataSource;

  StatisticsRepositoryImpl(this.localDataSource);

  @override
  Future<void> addActivity(ActivityEntity activity) {
    return localDataSource.addActivity(activity);
  }

  @override
  Future<void> addFood(FoodEntity food) {
    return localDataSource.addFood(food);
  }

  @override
  Future<void> deleteActivity(String id) {
    return localDataSource.deleteActivity(id);
  }

  @override
  Future<void> deleteFood(String id) {
    return localDataSource.deleteFood(id);
  }

  @override
  Future<void> updateActivitiesRatings(List<ActivityEntity> activities) {
    return localDataSource.updateActivitiesRating(activities);
  }

  @override
  Future<void> updateFoodRatings(List<FoodEntity> foods) {
    return localDataSource.updateFoodRating(foods);
  }

  @override
  Future<void> updateActivityName(String id, String name) {
    return localDataSource.updateActivityName(id, name);
  }

  @override
  Future<void> updateFoodName(String id, String name) {
    return localDataSource.updateFoodName(id, name);
  }

  @override
  Future<List<ActivityEntity>> getAllActivities() {
    return localDataSource.getAllActivities();
  }

  @override
  Future<List<FoodEntity>> getAllFoods() {
    return localDataSource.getAllFoods();
  }
}
