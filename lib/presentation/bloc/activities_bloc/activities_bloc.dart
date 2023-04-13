import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final activities = <ActivityEntity>[];
  final _removedActivitiesIds = <String>[];
  final _addedActivitiesIds = <String>[];
  final _pickedActivities = <ActivityEntity>[];
  // TODO: assign this variable in init
  bool _isCreate = false;
  Mood _oldMood = Mood.mediocre;
  // TODO: need event for changing mood
  Mood _newMood = Mood.mediocre;

  ActivitiesBloc() : super(const ActivitiesInitial([])) {
    on<ActivitiesEvent>((event, emit) async {
      if (event is InitActivitiesBlocEvent) {
        emit(ActivitiesPendingState(activities));

        _isCreate = event.isCreate;
        _oldMood = event.originalMood;
        _newMood = _oldMood;

        // TODO: load activities

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

          //TODO: then make call to update these activities

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

        //TODO: then make call to update these activities

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
          //TODO: call for update
          activities[index] = activities[index].copyWith(name: event.newName);
        }

        emit(ActivitiesLoadedState(activities));
      }
    });
  }
}
