part of 'activities_bloc.dart';

abstract class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();

  @override
  List<Object> get props => [];
}

class InitActivitiesBlocEvent extends ActivitiesEvent {
  final bool isCreate;
  final Mood originalMood;
  final DayEntity? day;

  const InitActivitiesBlocEvent({
    required this.isCreate,
    required this.originalMood,
    this.day,
  });
}

class ChangeMoodForActivitiesEvent extends ActivitiesEvent {
  final Mood newMood;

  const ChangeMoodForActivitiesEvent(this.newMood);
}

class SelectActivityEvent extends ActivitiesEvent {
  final String activityId;

  const SelectActivityEvent(this.activityId);
}

class UnselectActivityEvent extends ActivitiesEvent {
  final String activityId;

  const UnselectActivityEvent(this.activityId);
}

class ActivitiesSaveDayEvent extends ActivitiesEvent {}

class ChangeActivityNameEvent extends ActivitiesEvent {
  final String activityId;
  final String newName;

  const ChangeActivityNameEvent({
    required this.activityId,
    required this.newName,
  });
}
