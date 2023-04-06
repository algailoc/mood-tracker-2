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
  const DaySelected({
    required DayEntity dayEntity,
  }) : super(
          dayEntity: dayEntity,
        );
}

class DayAddPending extends DayState {
  const DayAddPending() : super(dayEntity: null);
}

class DayAddError extends DayState {
  final String error;

  const DayAddError({required this.error}) : super(dayEntity: null);
}

class DayAddSuccess extends DayState {
  const DayAddSuccess({
    required DayEntity dayEntity,
  }) : super(
          dayEntity: dayEntity,
        );
}

class DayUpdated extends DayState {
  const DayUpdated({
    required DayEntity dayEntity,
  }) : super(
          dayEntity: dayEntity,
        );
}
