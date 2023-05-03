import 'package:mood_tracker_2/data/models/day_model.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

const _mockActivitiesSlashFoods = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
];

final mockDays = [
  DayModel(
    id: '1',
    date: DateTime(2023, 1, 1),
    mood: Mood.bad,
    activities: _mockActivitiesSlashFoods,
    foods: _mockActivitiesSlashFoods,
    goodStuff: _mockGoodStuff,
    badStuff: _mockBadStuff,
    description: _mockDescription,
  ),
  DayModel(
    id: '2',
    date: DateTime(2023, 1, 2),
    mood: Mood.great,
    activities: _mockActivitiesSlashFoods,
    foods: _mockActivitiesSlashFoods,
    goodStuff: _mockGoodStuff,
    badStuff: _mockBadStuff,
    description: _mockDescription,
  ),
  DayModel(
    id: '3',
    date: DateTime(2023, 1, 3),
    mood: Mood.good,
    activities: _mockActivitiesSlashFoods,
    foods: _mockActivitiesSlashFoods,
    goodStuff: _mockGoodStuff,
    badStuff: _mockBadStuff,
    description: _mockDescription,
  ),
  DayModel(
    id: '4',
    date: DateTime(2023, 1, 4),
    mood: Mood.awful,
    activities: _mockActivitiesSlashFoods,
    foods: _mockActivitiesSlashFoods,
    goodStuff: _mockGoodStuff,
    badStuff: _mockBadStuff,
    description: _mockDescription,
  ),
  DayModel(
    id: '5',
    date: DateTime(2023, 1, 5),
    mood: Mood.mediocre,
    activities: _mockActivitiesSlashFoods,
    foods: _mockActivitiesSlashFoods,
    goodStuff: _mockGoodStuff,
    badStuff: _mockBadStuff,
    description: _mockDescription,
  ),
];

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

const _mockGoodStuff = [
  'As the rental car rolled to a stop on the dark road, her fear increased by the moment',
  'You bite up because of your lower jaw',
  'Just because the water is red doesn\'t mean you can\'t drink it'
];
const _mockBadStuff = [
  'He found the end of the rainbow and was surprised at what he found there',
  'There were three sphered rocks congregating in a cubed room'
      'He ended up burning his fingers poking someone else\'s fire',
];

const _mockDescription =
    'Lorem Ipsum - это текст-"рыба", часто используемый в печати и вэб-дизайне. Lorem Ipsum является стандартной "рыбой" для текстов на латинице с начала XVI века. В то время некий безымянный печатник создал большую коллекцию размеров и форм шрифтов, используя Lorem Ipsum для распечатки образцов. Lorem Ipsum не только успешно пережил без заметных изменений пять веков, но и перешагнул в электронный дизайн. Его популяризации в новое время послужили публикация листов Letraset с образцами Lorem Ipsum в 60-х годах и, в более недавнее время, программы электронной вёрстки типа Aldus PageMaker, в шаблонах которых используется Lorem Ipsum.';
