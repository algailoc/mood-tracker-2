import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/errors.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/usecases/days_list_usecase.dart';

part 'days_list_event.dart';
part 'days_list_state.dart';

class DaysListBloc extends Bloc<DaysListEvent, DaysListState> {
  final DaysListUsecase usecase;

  final List<DayEntity> days = [];

  DaysListBloc(this.usecase) : super(const DaysListInitial()) {
    on<DaysListEvent>((event, emit) async {
      if (event is FetchDaysListEvent) {
        emit(DaysListPending(days: days));
        if (usecase.addedDay != null) {
          days.add(usecase.addedDay!);
          days.sort((a, b) => b.date.compareTo(a.date));
          usecase.setAddedDay(null);

          emit(DaysListLoaded(days));
          return;
        }

        try {
          final result = await usecase.getDaysList();
          days.clear();
          days.addAll(result);
          emit(DaysListLoaded(days));
        } catch (e) {
          if (e is DaysParseException) {
            emit(DaysListLoadingError(
              error: 'Ошибка при расшифровке',
              days: days,
            ));
          } else {
            emit(DaysListLoadingError(
              error: 'Ошибка при загрузке списка',
              days: days,
            ));
          }
        }
      }
    });
  }
}
