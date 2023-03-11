import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

class FoodModel extends FoodEntity {
  const FoodModel({
    required String id,
    required String name,
    required Map<Mood, int> rating,
    bool original = true,
  }) : super(
          id: id,
          name: name,
          rating: rating,
          original: original,
        );

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

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    Map<Mood, int> resultRating = {};

    for (var key in json['rating']) {
      resultRating[Mood.values[key]] = json['rating'][key];
    }

    return FoodModel(
      id: json['id'],
      name: json['name'],
      rating: resultRating,
      original: json['original'],
    );
  }

  factory FoodModel.fromEntity(FoodEntity entity) {
    return FoodModel(
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
