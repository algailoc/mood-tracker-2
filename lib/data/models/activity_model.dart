import 'dart:convert';

import 'package:mood_tracker_2/domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);

  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
    });
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(id: json['id'], name: json['name']);
  }

  factory ActivityModel.fromEntity(ActivityEntity entity) {
    return ActivityModel(id: entity.id, name: entity.name);
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
