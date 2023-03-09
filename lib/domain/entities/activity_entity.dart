import 'package:equatable/equatable.dart';

abstract class ActivityEntity extends Equatable {
  final String id;
  final String name;

  const ActivityEntity({required this.id, required this.name});
}
