// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';

part 'day_edit_event.dart';
part 'day_edit_state.dart';

class DayEditBloc extends Bloc<DayEditEvent, DayEditState> {
  late final DayEntity? day;
  late final TextEditingController descriptionController;

  DayEditBloc() : super(DayEditInitial()) {
    on<DayEditEvent>((event, emit) {
      if (event is InitDayEditEvent) {
        day = event.day;
        if (day != null) {
          descriptionController = TextEditingController(
            text: day!.description ?? '',
          );
        } else {
          descriptionController = TextEditingController();
        }

        emit(DayEditInitedEvent(descriptionController));
      }
    });
  }
}
