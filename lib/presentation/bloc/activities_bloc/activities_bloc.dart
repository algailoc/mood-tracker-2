import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/domain/usecases/statistics_usecase.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final StatisticsUsecase usecase;

  final activities = <ActivityEntity>[];
  final _removedActivitiesIds = <String>{};
  final _addedActivitiesIds = <String>{};
  final _pickedActivities = <String>{};

  Set<String> _originalActivities = {};

  bool _isCreate = false;
  Mood _oldMood = Mood.mediocre;
  Mood _newMood = Mood.mediocre;

  bool isActivityPicked(String id) {
    return _pickedActivities.contains(id);
  }

  ActivitiesBloc(this.usecase) : super(const ActivitiesInitial([])) {
    on<ActivitiesEvent>((event, emit) async {
      if (event is InitActivitiesBlocEvent) {
        emit(ActivitiesPendingState(activities));

        _isCreate = event.isCreate;
        _oldMood = event.originalMood;
        _newMood = _oldMood;

        activities.addAll(await usecase.getAllActivities());

        if (event.day != null) {
          _originalActivities = event.day!.activities.toSet();
          _pickedActivities.addAll(_originalActivities);
        }

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////
      // if event is save day /////
      /////////////////////////////

      else if (event is ActivitiesSaveDayEvent) {
        final listToUpdate = <ActivityEntity>[];

        if (_oldMood != _newMood && !_isCreate) {
          final listToUpdate = _pickedActivities
              .map(
                (e) => activities
                    .firstWhere((element) => element.id == e)
                    .changeRating(
                      oldMood: _oldMood,
                      newMood: _newMood,
                    ),
              )
              .toList();

          await usecase.updateActivitiesRatings(listToUpdate);

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

        await usecase.updateActivitiesRatings(listToUpdate);

        emit(ActivitiesLoadedState(activities));
      }

      ////////////////////////////////////
      // if event is choose activity /////
      ////////////////////////////////////

      else if (event is SelectActivityEvent) {
        emit(ActivitiesPendingState(activities));
        if (_originalActivities.contains(event.activityId)) {
          if (_removedActivitiesIds.contains(event.activityId)) {
            _removedActivitiesIds.remove(event.activityId);
          } else {
            _addedActivitiesIds.add(event.activityId);
          }
        }

        _pickedActivities.add(event.activityId);

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is unchoose activity /////
      //////////////////////////////////////

      else if (event is UnselectActivityEvent) {
        emit(ActivitiesPendingState(activities));
        if (_originalActivities.contains(event.activityId)) {
          if (_addedActivitiesIds.contains(event.activityId)) {
            _addedActivitiesIds.remove(event.activityId);
          } else {
            _removedActivitiesIds.add(event.activityId);
          }
        }

        _pickedActivities.remove(event.activityId);

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is update activity ///////
      //////////////////////////////////////

      else if (event is ChangeActivityNameEvent) {
        emit(ActivitiesPendingState(activities));
        final index =
            activities.indexWhere((element) => element.id == event.activityId);
        if (index != -1) {
          await usecase.updateActivityName(event.activityId, event.newName);
          activities[index] = activities[index].copyWith(name: event.newName);
        }

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is delete activity ///////
      //////////////////////////////////////

      else if (event is DeleteActivityEvent) {
        emit(ActivitiesPendingState(activities));
        await usecase.deleteActivity(event.id);
        final index =
            activities.indexWhere((element) => element.id == event.id);
        if (index != -1) {
          activities.removeAt(index);
        }

        SmartDialog.dismiss();

        emit(ActivitiesLoadedState(activities));
      }

      //////////////////////////////////////
      // if event is create activity ///////
      //////////////////////////////////////

      else if (event is CreateActivityEvent) {
        emit(ActivitiesPendingState(activities));

        final activity = await usecase.addActivity(event.name);
        activities.add(activity);

        // Нужно также добавлять в DayBloc, но пока непонятно как это лучше сделать
        // _addedActivitiesIds.add(activity.id);
        // _pickedActivities.add(activity.id);

        emit(ActivitiesLoadedState(activities));
      }
    });
  }
}
