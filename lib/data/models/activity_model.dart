import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required super.id,
    required super.name,
    required super.rating,
    super.original,
  });

  String toJson() {
    final jsonRating = {};

    for (var rate in rating.keys) {
      jsonRating[rate.name] = rating[rate];
    }

    return jsonEncode({
      'id': id,
      'name': name,
      'rating': jsonRating,
      'original': original,
    });
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    Map<Mood, int> resultRating = {};

    for (var key in Map<String, int>.from(json['rating']).keys) {
      resultRating[Mood.values.byName(key)] = json['rating'][key];
    }

    return ActivityModel(
      id: json['id'],
      name: json['name'],
      rating: resultRating,
      original: json['original'],
    );
  }

  factory ActivityModel.fromEntity(ActivityEntity entity) {
    return ActivityModel(
      id: entity.id,
      name: entity.name,
      rating: entity.rating,
      original: entity.original,
    );
  }

  @override
  List<Object?> get props => [id, name, rating, original];

  @override
  bool? get stringify => true;
}
