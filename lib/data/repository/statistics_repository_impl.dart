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
  Future<void> updateActivities(List<ActivityEntity> activities) {
    return localDataSource.updateActivities(activities);
  }

  @override
  Future<void> updateFood(List<FoodEntity> foods) {
    return localDataSource.updateFood(foods);
  }
}
