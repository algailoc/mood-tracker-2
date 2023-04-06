part of 'day_bloc.dart';

abstract class DayEvent extends Equatable {
  const DayEvent();

  @override
  List<Object> get props => [];
}

class InitDayEvent extends DayEvent {
  final DayEntity? day;
  final DateTime date;

  const InitDayEvent({this.day, required this.date});
}

class SaveDayEvent extends DayEvent {}

class UpdateMoodEvent extends DayEvent {
  final Mood mood;

  const UpdateMoodEvent(this.mood);
}

class AddActivityEvent extends DayEvent {
  final ActivityEntity activity;

  const AddActivityEvent(this.activity);
}

class RemoveActivityEvent extends DayEvent {
  final ActivityEntity activity;

  const RemoveActivityEvent(this.activity);
}

class AddFoodEvent extends DayEvent {
  final FoodEntity food;

  const AddFoodEvent(this.food);
}

class RemoveFoodEvent extends DayEvent {
  final FoodEntity food;

  const RemoveFoodEvent(this.food);
}

class AddGoodStuffEvent extends DayEvent {
  final String goodStuff;

  const AddGoodStuffEvent(this.goodStuff);
}

class RemoveGoodStuffEvent extends DayEvent {
  final String goodStuff;

  const RemoveGoodStuffEvent(this.goodStuff);
}

class AddBadStuffEvent extends DayEvent {
  final String badStuff;

  const AddBadStuffEvent(this.badStuff);
}

class RemoveBadStuffEvent extends DayEvent {
  final String badStuff;

  const RemoveBadStuffEvent(this.badStuff);
}

class UpdateDescriptionEvent extends DayEvent {
  final String description;

  const UpdateDescriptionEvent(this.description);
}
