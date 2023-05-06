import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

// final mockDays = [
//   DayModel(
//     id: '1',
//     date: DateTime(2023, 1, 1),
//     mood: Mood.bad,
//     activities: _mockActivitiesSlashFoods,
//     foods: _mockActivitiesSlashFoods,
//     goodStuff: _mockGoodStuff,
//     badStuff: _mockBadStuff,
//     description: _mockDescription,
//   ),
//   DayModel(
//     id: '2',
//     date: DateTime(2023, 1, 2),
//     mood: Mood.great,
//     activities: _mockActivitiesSlashFoods,
//     foods: _mockActivitiesSlashFoods,
//     goodStuff: _mockGoodStuff,
//     badStuff: _mockBadStuff,
//     description: _mockDescription,
//   ),
//   DayModel(
//     id: '3',
//     date: DateTime(2023, 1, 3),
//     mood: Mood.good,
//     activities: _mockActivitiesSlashFoods,
//     foods: _mockActivitiesSlashFoods,
//     goodStuff: _mockGoodStuff,
//     badStuff: _mockBadStuff,
//     description: _mockDescription,
//   ),
//   DayModel(
//     id: '4',
//     date: DateTime(2023, 1, 4),
//     mood: Mood.awful,
//     activities: _mockActivitiesSlashFoods,
//     foods: _mockActivitiesSlashFoods,
//     goodStuff: _mockGoodStuff,
//     badStuff: _mockBadStuff,
//     description: _mockDescription,
//   ),
//   DayModel(
//     id: '5',
//     date: DateTime(2023, 1, 5),
//     mood: Mood.mediocre,
//     activities: _mockActivitiesSlashFoods,
//     foods: _mockActivitiesSlashFoods,
//     goodStuff: _mockGoodStuff,
//     badStuff: _mockBadStuff,
//     description: _mockDescription,
//   ),
// ];

final mockActivities = [
  const ActivityEntity(
    id: '1',
    name: 'Программирование',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const ActivityEntity(
    id: '2',
    name: 'Езда на велосипеде',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const ActivityEntity(
    id: '3',
    name: 'Просмотр сериалов',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const ActivityEntity(
    id: '4',
    name: 'Послеобеденный сон',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const ActivityEntity(
    id: '5',
    name: 'Компьютерные игры',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const ActivityEntity(
    id: '6',
    name: 'Прогулка',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
];

final mockFoods = [
  const FoodEntity(
    id: '1',
    name: 'Курица',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const FoodEntity(
    id: '2',
    name: 'Пшено',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const FoodEntity(
    id: '3',
    name: 'Макароны',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const FoodEntity(
    id: '4',
    name: 'Сосиски',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const FoodEntity(
    id: '5',
    name: 'Пюре',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
  const FoodEntity(
    id: '6',
    name: 'Лазанья',
    rating: {
      Mood.awful: 0,
      Mood.bad: 0,
      Mood.mediocre: 0,
      Mood.good: 0,
      Mood.great: 0,
    },
    original: true,
  ),
];
