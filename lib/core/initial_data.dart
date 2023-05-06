import 'package:mood_tracker_2/data/models/activity_model.dart';
import 'package:mood_tracker_2/data/models/food_model.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

List<ActivityModel> generateInitialActivities() {
  int count = 0;
  final result = <ActivityModel>[];

  for (var name in _activities) {
    result.add(
      ActivityModel(
        id: count.toString(),
        name: name,
        rating: _rating,
      ),
    );
    count++;
  }

  return result;
}

const _activities = [
  'Программирование',
  'Езда на велосипеде',
  'Просмотр сериалов',
  'Послеобеденный сон',
  'Компьютерные игры',
  'Прогулка',
  'Встреча с друзьями',
  'Чтение книг',
  'Кино',
  'Еда в кафе',
];

const _rating = {
  Mood.awful: 0,
  Mood.bad: 0,
  Mood.mediocre: 0,
  Mood.good: 0,
  Mood.great: 0,
};

List<FoodModel> generateInitialFoods() {
  int count = 0;
  final result = <FoodModel>[];

  for (var name in _foods) {
    result.add(
      FoodModel(
        id: count.toString(),
        name: name,
        rating: _rating,
      ),
    );
    count++;
  }

  return result;
}

const _foods = [
  'Молоко',
  'Яйца',
  'Хлеб',
  'Кофе',
  'Чай',
  'Картошка',
  'Пшено',
  'Манка',
  'Рис',
  'Гречка',
  'Салат',
  'Огурцы',
  'Помидоры',
  'Фрукты',
  'Бананы',
  'Яблоки',
];
