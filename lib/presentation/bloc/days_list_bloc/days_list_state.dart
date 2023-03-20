part of 'days_list_bloc.dart';

abstract class DaysListState extends Equatable {
  final List<DayEntity> days;

  const DaysListState({
    this.days = const [],
  });

  @override
  List<Object> get props => [];
}

class DaysListInitial extends DaysListState {}

class DaysListPending extends DaysListState {}

class DaysListLoadingError extends DaysListState {
  final String error;

  const DaysListLoadingError(this.error);
}

class DaysListLoaded extends DaysListState {
  final List<DayEntity> loadedDays;

  const DaysListLoaded(this.loadedDays);
}
