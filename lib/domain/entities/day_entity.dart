import 'package:equatable/equatable.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class DayEntity extends Equatable {
  final String id;
  final DateTime date;
  final Mood mood;
  final List<String> activities;
  final List<String> foods;
  final List<String> goodStuff;
  final List<String> badStuff;

  const DayEntity({
    required this.id,
    required this.date,
    required this.mood,
    this.activities = const [],
    this.foods = const [],
    this.goodStuff = const [],
    this.badStuff = const [],
  });

  DayEntity copyWith({
    String? id,
    DateTime? date,
    Mood? mood,
    List<String>? activities,
    List<String>? foods,
    List<String>? goodStuff,
    List<String>? badStuff,
  }) {
    return DayEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      activities: activities ?? this.activities,
      foods: foods ?? this.foods,
      goodStuff: goodStuff ?? this.goodStuff,
      badStuff: badStuff ?? this.badStuff,
    );
  }

  @override
  List<Object?> get props => [id, date, mood, foods, activities];

  @override
  bool? get stringify => true;
}
