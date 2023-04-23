part of 'day_bloc.dart';

abstract class DayState extends Equatable {
  final DayEntity? dayEntity;

  const DayState({required this.dayEntity});

  @override
  List<Object> get props => [];
}

class DayInitial extends DayState {
  const DayInitial() : super(dayEntity: null);
}

class DaySelected extends DayState {
  const DaySelected({required super.dayEntity});
}

class DayAddPending extends DayState {
  const DayAddPending({required super.dayEntity});
}

class DayAddError extends DayState {
  final String error;

  const DayAddError({required this.error, required super.dayEntity});
}

class DayAddSuccess extends DayState {
  const DayAddSuccess({required super.dayEntity});
}

class DayUpdated extends DayState {
  const DayUpdated({required super.dayEntity});
}
