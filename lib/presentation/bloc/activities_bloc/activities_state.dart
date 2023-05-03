part of 'activities_bloc.dart';

abstract class ActivitiesState extends Equatable {
  final List<ActivityEntity> activities;

  const ActivitiesState(this.activities);

  @override
  List<Object> get props => [activities];
}

class ActivitiesInitial extends ActivitiesState {
  const ActivitiesInitial(super.activities);
}

class ActivitiesLoadedState extends ActivitiesState {
  const ActivitiesLoadedState(super.activities);
}

class ActivitiesPendingState extends ActivitiesState {
  const ActivitiesPendingState(super.activities);
}

class ActivitiesErrorState extends ActivitiesState {
  final String error;

  const ActivitiesErrorState(
    super.activities, {
    required this.error,
  });
}
