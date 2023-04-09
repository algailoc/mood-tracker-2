import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final activities = <ActivityEntity>[];
  final _removedActivitiesIds = <String>[];
  final _addedActivitiesIds = <String>[];

  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<ActivitiesEvent>((event, emit) async {
      // TODO: implement event handler

      //////////////////////////////
      // if event is save day /////
      /////////////////////////////
      final listToUpdate = <ActivityEntity>[];

      final removedActivities = activities
          .where(
            (e) => _removedActivitiesIds.contains(e.id),
          )
          .toList();
      for (var activity in removedActivities) {
        final newActivity = activity.removeRating(Mood.good);
        listToUpdate.add(newActivity);
      }

      final addedActivities = activities
          .where(
            (e) => _addedActivitiesIds.contains(e.id),
          )
          .toList();
      for (var activity in addedActivities) {
        final newActivity = activity.addRating(Mood.good);
        listToUpdate.add(newActivity);
      }

      // same for food

      // then make call to update these activities

      ////////////////////////////////////
      // if event is choose activity /////
      ////////////////////////////////////

      if (_removedActivitiesIds.contains('event.id')) {
        _removedActivitiesIds.remove('event.id');
      } else {
        _addedActivitiesIds.add('event.id');
      }

      //////////////////////////////////////
      // if event is unchoose activity /////
      //////////////////////////////////////

      if (_addedActivitiesIds.contains('event.id')) {
        _addedActivitiesIds.remove('event.id');
      } else {
        _removedActivitiesIds.add('event.id');
      }

      //////////////////////////////////////
      // if event is update activity ///////
      //////////////////////////////////////

      final index =
          activities.indexWhere((element) => element.id == 'event.id');
      if (index > -1) {
        // call for update
        activities[index] = activities[index].copyWith(name: 'event.name');
      }
    });
  }
}
