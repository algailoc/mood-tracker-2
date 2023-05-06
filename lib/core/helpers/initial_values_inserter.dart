import 'package:hive/hive.dart';
import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/core/initial_data.dart';

Future<void> insertInitialValues() async {
  final actEntities = generateInitialActivities();
  final foodEntities = generateInitialFoods();

  final actsBox = Hive.box(activitiesBoxName);
  final foodsBox = Hive.box(foodsBoxName);

  for (var act in actEntities) {
    actsBox.add(act.toJson());
  }

  for (var food in foodEntities) {
    foodsBox.add(food.toJson());
  }
}
