part of 'day_edit_bloc.dart';

abstract class DayEditState extends Equatable {
  const DayEditState();

  @override
  List<Object> get props => [];
}

class DayEditInitial extends DayEditState {}

class DayEditInitedEvent extends DayEditState {
  final TextEditingController descriptionController;

  const DayEditInitedEvent(this.descriptionController);
}
