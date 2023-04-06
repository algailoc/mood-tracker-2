part of 'days_list_bloc.dart';

abstract class DaysListState extends Equatable {
  final List<DayEntity> days;

  const DaysListState({
    required this.days,
  });

  @override
  List<Object> get props => [];
}

class DaysListInitial extends DaysListState {
  const DaysListInitial() : super(days: const []);
}

class DaysListPending extends DaysListState {
  const DaysListPending({
    required List<DayEntity> days,
  }) : super(days: days);
}

class DaysListLoadingError extends DaysListState {
  final String error;

  const DaysListLoadingError({
    required this.error,
    required List<DayEntity> days,
  }) : super(days: days);
}

class DaysListLoaded extends DaysListState {
  final List<DayEntity> loadedDays;

  const DaysListLoaded(this.loadedDays) : super(days: loadedDays);
}
