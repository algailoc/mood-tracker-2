import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/domain/usecases/statistics_usecase.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final StatisticsUsecase usecase;

  final activities = <ActivityEntity>[];
  final _removedActivitiesIds = <String>[];
  final _addedActivitiesIds = <String>[];
  final _pickedActivities = <ActivityEntity>[];
  bool _isCreate = false;
  Mood _oldMood = Mood.mediocre;
  Mood _newMood = Mood.mediocre;

  ActivitiesBloc(this.usecase) : super(const ActivitiesInitial([])) {
    on<ActivitiesEvent>((event, emit) async {
      if (event is InitActivitiesBlocEvent) {
        emit(ActivitiesPendingState(activities));

        _isCreate = event.isCreate;
        _oldMood = event.originalMood;
        _newMood = _oldMood;

        activities.addAll(await usecase.getAllActivities());

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////
      // if event is save day /////
      /////////////////////////////

      else if (event is SaveDayEvent) {
        final listToUpdate = <ActivityEntity>[];

        if (_oldMood != _newMood && !_isCreate) {
          final listToUpdate = _pickedActivities
              .map(
                (e) => e.changeRating(
                  oldMood: _oldMood,
                  newMood: _newMood,
                ),
              )
              .toList();

          await usecase.updateActivitiesRatings(activities);

          listToUpdate.clear();
        }

        final removedActivities = activities
            .where(
              (e) => _removedActivitiesIds.contains(e.id),
            )
            .toList();
        for (var activity in removedActivities) {
          final newActivity = activity.removeRating(_newMood);
          listToUpdate.add(newActivity);
        }

        final addedActivities = activities
            .where(
              (e) => _addedActivitiesIds.contains(e.id),
            )
            .toList();
        for (var activity in addedActivities) {
          final newActivity = activity.addRating(_newMood);
          listToUpdate.add(newActivity);
        }

        await usecase.updateActivitiesRatings(activities);

        emit(ActivitiesLoadedState(activities));
      }

      ////////////////////////////////////
      // if event is choose activity /////
      ////////////////////////////////////

      else if (event is SelectActivityEvent) {
        if (_removedActivitiesIds.contains(event.activityId)) {
          _removedActivitiesIds.remove(event.activityId);
        } else {
          _addedActivitiesIds.add(event.activityId);
        }

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is unchoose activity /////
      //////////////////////////////////////

      else if (event is UnselectActivityEvent) {
        if (_addedActivitiesIds.contains(event.activityId)) {
          _addedActivitiesIds.remove(event.activityId);
        } else {
          _removedActivitiesIds.add(event.activityId);
        }

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is update activity ///////
      //////////////////////////////////////

      else if (event is ChangeActivityNameEvent) {
        final index =
            activities.indexWhere((element) => element.id == event.activityId);
        if (index > -1) {
          await usecase.updateActivityName(event.activityId, event.newName);
          activities[index] = activities[index].copyWith(name: event.newName);
        }

        emit(ActivitiesLoadedState(activities));
      }
    });
  }
}
