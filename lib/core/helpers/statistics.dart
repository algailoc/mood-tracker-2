import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

Map<Mood, List<ActivityEntity>> sortActivitiesByMood(
  List<ActivityEntity> activities,
) {
  List<ActivityEntity> moodGreat = activities.where(
    (element) {
      return element.rating[Mood.great]! > 0;
    },
  ).toList();
  moodGreat
      .sort((a, b) => b.rating[Mood.great]!.compareTo(a.rating[Mood.great]!));

  List<ActivityEntity> moodGood = activities
      .where(
        (element) => element.rating[Mood.good]! > 0,
      )
      .toList();
  moodGood.sort((a, b) => b.rating[Mood.good]!.compareTo(a.rating[Mood.good]!));

  List<ActivityEntity> moodMediocre = activities
      .where(
        (element) => element.rating[Mood.mediocre]! > 0,
      )
      .toList();
  moodMediocre.sort(
      (a, b) => b.rating[Mood.mediocre]!.compareTo(a.rating[Mood.mediocre]!));

  List<ActivityEntity> moodBad = activities
      .where(
        (element) => element.rating[Mood.bad]! > 0,
      )
      .toList();
  moodBad.sort((a, b) => b.rating[Mood.bad]!.compareTo(a.rating[Mood.bad]!));

  List<ActivityEntity> moodAwful = activities
      .where(
        (element) => element.rating[Mood.awful]! > 0,
      )
      .toList();
  moodAwful
      .sort((a, b) => b.rating[Mood.awful]!.compareTo(a.rating[Mood.awful]!));

  final Map<Mood, List<ActivityEntity>> sortedResult = {
    Mood.great: moodGreat,
    Mood.good: moodGood,
    Mood.mediocre: moodMediocre,
    Mood.bad: moodBad,
    Mood.awful: moodAwful,
  };

  return sortedResult;
}

Map<Mood, List<FoodEntity>> sortFoodsByMood(
  List<FoodEntity> foods,
) {
  List<FoodEntity> moodGreat = foods.where(
    (element) {
      return element.rating[Mood.great]! > 0;
    },
  ).toList();
  moodGreat
      .sort((a, b) => b.rating[Mood.great]!.compareTo(a.rating[Mood.great]!));

  List<FoodEntity> moodGood = foods
      .where(
        (element) => element.rating[Mood.good]! > 0,
      )
      .toList();
  moodGood.sort((a, b) => b.rating[Mood.good]!.compareTo(a.rating[Mood.good]!));

  List<FoodEntity> moodMediocre = foods
      .where(
        (element) => element.rating[Mood.mediocre]! > 0,
      )
      .toList();
  moodMediocre.sort(
      (a, b) => b.rating[Mood.mediocre]!.compareTo(a.rating[Mood.mediocre]!));

  List<FoodEntity> moodBad = foods
      .where(
        (element) => element.rating[Mood.bad]! > 0,
      )
      .toList();
  moodBad.sort((a, b) => b.rating[Mood.bad]!.compareTo(a.rating[Mood.bad]!));

  List<FoodEntity> moodAwful = foods
      .where(
        (element) => element.rating[Mood.awful]! > 0,
      )
      .toList();
  moodAwful
      .sort((a, b) => b.rating[Mood.awful]!.compareTo(a.rating[Mood.awful]!));

  final Map<Mood, List<FoodEntity>> sortedResult = {
    Mood.great: moodGreat,
    Mood.good: moodGood,
    Mood.mediocre: moodMediocre,
    Mood.bad: moodBad,
    Mood.awful: moodAwful,
  };

  return sortedResult;
}
