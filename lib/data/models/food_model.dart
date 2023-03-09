import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/food_entity.dart';

class FoodModel extends FoodEntity {
  const FoodModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
    });
  }

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(id: json['id'], name: json['name']);
  }

  factory FoodModel.fromEntity(FoodEntity entity) {
    return FoodModel(id: entity.id, name: entity.name);
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
