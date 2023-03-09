import 'package:equatable/equatable.dart';

abstract class FoodEntity extends Equatable {
  final String id;
  final String name;

  const FoodEntity({required this.id, required this.name});
}
