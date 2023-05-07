part of 'day_edit_bloc.dart';

abstract class DayEditEvent extends Equatable {
  const DayEditEvent();

  @override
  List<Object> get props => [];
}

class InitDayEditEvent extends DayEditEvent {
  final DayEntity? day;

  const InitDayEditEvent(this.day);
}
