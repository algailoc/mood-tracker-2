import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final String id;
  final String name;

  const ActivityEntity({required this.id, required this.name});

  ActivityEntity copyWith({String? name}) {
    return ActivityEntity(id: id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
