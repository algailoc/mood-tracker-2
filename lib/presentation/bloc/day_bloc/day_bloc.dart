import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/domain/usecases/day_usecase.dart';
import 'package:mood_tracker_2/domain/usecases/days_list_usecase.dart';
import 'package:mood_tracker_2/get_it.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  final DayUsecase usecase;

  late DayEntity day;
  bool? _isCreateDay;
  bool get isCreateDay => _isCreateDay ?? false;
  bool _wasChanged = false;
  bool get wasChanged => _wasChanged;

  DayBloc(this.usecase) : super(const DayInitial()) {
    on<DayEvent>((event, emit) async {
      void emitLoadedState() {
        emit(DaySelected(dayEntity: day));
      }

      void changeChanged() {
        if (!_wasChanged) {
          _wasChanged = true;
        }

        emit(DayChanging(dayEntity: day));
      }

      if (event is InitDayEvent) {
        if (event.day != null) {
          print(event.day);
          day = await usecase.getDay(event.day!.id);
        } else {
          day = DayEntity(
            id: '0',
            date: event.date,
            mood: Mood.mediocre,
          );
        }
        emit(DayChanging(dayEntity: day));

        _isCreateDay = event.day == null;

        emitLoadedState();
      } else if (event is UpdateMoodEvent) {
        changeChanged();
        day = day.copyWith(mood: event.mood);

        emitLoadedState();
      } else if (event is AddActivityEvent) {
        changeChanged();
        final newActivities = [...day.activities];
        newActivities.add(event.activity.id);
        day = day.copyWith(activities: newActivities);

        emitLoadedState();
      } else if (event is RemoveActivityEvent) {
        changeChanged();
        final newActivities = [...day.activities];

        newActivities.remove(event.activity.id);
        day = day.copyWith(activities: newActivities);

        emitLoadedState();
      } else if (event is AddFoodEvent) {
        changeChanged();
        final newFoods = [...day.foods];
        newFoods.add(event.food.id);
        day = day.copyWith(foods: newFoods);

        emitLoadedState();
      } else if (event is RemoveFoodEvent) {
        changeChanged();
        final newFoods = [...day.foods];
        newFoods.remove(event.food.id);
        day = day.copyWith(foods: newFoods);

        emitLoadedState();
      } else if (event is AddGoodStuffEvent) {
        changeChanged();

        final newGoodStuff = [...day.goodStuff];
        if (!newGoodStuff.contains(event.goodStuff)) {
          newGoodStuff.add(event.goodStuff);
        }
        day = day.copyWith(goodStuff: newGoodStuff);
        print('DAY GOOD STUFF ${day.goodStuff}');

        emitLoadedState();
      } else if (event is RemoveGoodStuffEvent) {
        changeChanged();
        final newGoodStuff = [...day.goodStuff];
        newGoodStuff.remove(event.goodStuff);

        day = day.copyWith(goodStuff: newGoodStuff);

        emitLoadedState();
      } else if (event is AddBadStuffEvent) {
        changeChanged();
        final newBadStuff = [...day.badStuff];
        if (!newBadStuff.contains(event.badStuff)) {
          newBadStuff.add(event.badStuff);
        }
        day = day.copyWith(badStuff: newBadStuff);
        print('DAY BAD STUFF ${day.badStuff}');

        emitLoadedState();
      } else if (event is RemoveBadStuffEvent) {
        changeChanged();
        final newBadStuff = [...day.badStuff];
        newBadStuff.remove(event.badStuff);
        day = day.copyWith(badStuff: newBadStuff);

        emitLoadedState();
      } else if (event is UpdateDescriptionEvent) {
        changeChanged();
        day = day.copyWith(description: event.description);

        emitLoadedState();
      } else if (event is SaveDayEvent) {
        emit(DayAddPending(dayEntity: day));
        if (_isCreateDay ?? false) {
          try {
            print('ADDING DAY $day');
            print(day.activities);
            print(day.foods);
            print(day.goodStuff);
            print(day.badStuff);
            final newDay = await usecase.addDay(day);

            getIt<DaysListUsecase>().setAddedDay(newDay);

            emit(DayAddSuccess(dayEntity: day));
          } catch (e, st) {
            debugPrint('error on creating day $e\n$st');
            emit(DayAddError(error: '', dayEntity: day));
          }
        } else {
          try {
            await usecase.updateDay(day);
            getIt<DaysListUsecase>().setAddedDay(day);

            emit(DayUpdated(dayEntity: day));
          } catch (e, st) {
            debugPrint('error on updating day $e\n$st');
            emit(DayAddError(error: '', dayEntity: day));
          }
        }
      }
    });
  }
}
