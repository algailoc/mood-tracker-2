part of 'day_bloc.dart';

abstract class DayState extends Equatable {
  const DayState();

  @override
  List<Object> get props => [];
}

class DayInitial extends DayState {}

class DaySelected extends DayState {
  final DayEntity? dayEntity;

  const DaySelected(this.dayEntity);
}

class DayAddPending extends DayState {}

class DayAddError extends DayState {
  final String error;

  const DayAddError(this.error);
}

class DayAddSuccess extends DayState {
  const DayAddSuccess();
}

class DayUpdated extends DayState {
  final DayEntity day;

  const DayUpdated(this.day);
}
