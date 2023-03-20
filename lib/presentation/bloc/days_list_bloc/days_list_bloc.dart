import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/errors.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/usecases/days_list_usecase.dart';

part 'days_list_event.dart';
part 'days_list_state.dart';

class DaysListBloc extends Bloc<DaysListEvent, DaysListState> {
  final DaysListUsecase usecase;

  final List<DayEntity> days = [];

  DaysListBloc(this.usecase) : super(DaysListInitial()) {
    on<DaysListEvent>((event, emit) async {
      if (event is FetchDaysListEvent) {
        emit(DaysListPending());
        try {
          final result = await usecase.getDaysList();
          days.clear();
          days.addAll(result);
          emit(DaysListLoaded(days));
        } catch (e) {
          if (e is DaysParseException) {
            emit(const DaysListLoadingError('Ошибка при расшифровке'));
          } else {
            emit(const DaysListLoadingError('Ошибка при загрузке списка'));
          }
        }
      } else if (event is AddDayEvent) {
        await usecase.addDay(event.day);
      }
    });
  }
}
