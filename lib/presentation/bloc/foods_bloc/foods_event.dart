part of 'foods_bloc.dart';

abstract class FoodsEvent extends Equatable {
  const FoodsEvent();

  @override
  List<Object> get props => [];
}

class InitFoodsBlocEvent extends FoodsEvent {
  final bool isCreate;
  final Mood originalMood;
  final DayEntity? day;

  const InitFoodsBlocEvent({
    required this.isCreate,
    required this.originalMood,
    this.day,
  });
}

class ChangeMoodForFoodsEvent extends FoodsEvent {
  final Mood newMood;

  const ChangeMoodForFoodsEvent(this.newMood);
}

class SelectFoodEvent extends FoodsEvent {
  final String foodId;

  const SelectFoodEvent(this.foodId);
}

class UnselectFoodEvent extends FoodsEvent {
  final String foodId;

  const UnselectFoodEvent(this.foodId);
}

class FoodsSaveDayEvent extends FoodsEvent {}

class ChangeFoodNameEvent extends FoodsEvent {
  final String foodId;
  final String newName;

  const ChangeFoodNameEvent({
    required this.foodId,
    required this.newName,
  });
}

class DeleteFoodEvent extends FoodsEvent {
  final String id;

  const DeleteFoodEvent(this.id);
}
