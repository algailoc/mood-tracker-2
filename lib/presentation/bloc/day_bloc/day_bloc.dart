import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/food_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/domain/usecases/day_usecase.dart';

part 'day_event.dart';
part 'day_state.dart';

class DayBloc extends Bloc<DayEvent, DayState> {
  final DayUsecase usecase;

  late DayEntity day;
  late final bool _isCreateDay;

  DayBloc(this.usecase) : super(const DayInitial()) {
    on<DayEvent>((event, emit) async {
      void emitLoadedState() {
        emit(DaySelected(dayEntity: day));
      }

      if (event is InitDayEvent) {
        day = event.day ??
            DayEntity(
              id: '0',
              date: event.date,
              mood: Mood.mediocre,
            );

        _isCreateDay = event.day == null;

        emitLoadedState();
      } else if (event is UpdateMoodEvent) {
        day = day.copyWith(mood: event.mood);

        emitLoadedState();
      } else if (event is AddActivityEvent) {
        final newActivities = day.activities;
        newActivities.add(event.activity.name);
        day = day.copyWith(activities: newActivities);

        emitLoadedState();
      } else if (event is RemoveActivityEvent) {
        final newActivities = day.activities;
        newActivities.remove(event.activity.name);
        day = day.copyWith(activities: newActivities);

        emitLoadedState();
      } else if (event is AddFoodEvent) {
        final newFoods = day.foods;
        newFoods.add(event.food.name);
        day = day.copyWith(activities: newFoods);

        emitLoadedState();
      } else if (event is RemoveFoodEvent) {
        final newFoods = day.foods;
        newFoods.remove(event.food.name);
        day = day.copyWith(activities: newFoods);

        emitLoadedState();
      } else if (event is AddGoodStuffEvent) {
        final newGoodStuff = day.goodStuff;
        newGoodStuff.add(event.goodStuff);
        day = day.copyWith(goodStuff: newGoodStuff);

        emitLoadedState();
      } else if (event is RemoveGoodStuffEvent) {
        final newGoodStuff = day.goodStuff;
        newGoodStuff.remove(event.goodStuff);
        day = day.copyWith(goodStuff: newGoodStuff);

        emitLoadedState();
      } else if (event is AddBadStuffEvent) {
        final newBadStuff = day.badStuff;
        newBadStuff.add(event.badStuff);
        day = day.copyWith(badStuff: newBadStuff);

        emitLoadedState();
      } else if (event is RemoveBadStuffEvent) {
        final newBadStuff = day.badStuff;
        newBadStuff.remove(event.badStuff);
        day = day.copyWith(badStuff: newBadStuff);

        emitLoadedState();
      } else if (event is UpdateDescriptionEvent) {
        day = day.copyWith(description: event.description);

        emitLoadedState();
      } else if (event is SaveDayEvent) {
        if (_isCreateDay) {
          // create
        } else {
          // update
        }
      }
    });
  }
}
