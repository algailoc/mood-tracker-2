part of 'days_list_bloc.dart';

abstract class DaysListEvent extends Equatable {
  const DaysListEvent();

  @override
  List<Object> get props => [];
}

class FetchDaysListEvent extends DaysListEvent {}
