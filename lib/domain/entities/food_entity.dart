import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  final String id;
  final String name;

  const FoodEntity({required this.id, required this.name});

  FoodEntity copyWith({String? name}) {
    return FoodEntity(id: id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
