import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/helpers/confirm_delete_dialog.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/act_or_food_search_bar.dart';
import 'package:mood_tracker_2/presentation/widgets/common/activity_item.dart';
import 'package:mood_tracker_2/presentation/widgets/common/create_activity_or_food_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/common/edit_activity_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class EditActivitiesBlock extends StatefulWidget {
  const EditActivitiesBlock({super.key});

  @override
  State<EditActivitiesBlock> createState() => _EditActivitiesBlockState();
}

class _EditActivitiesBlockState extends State<EditActivitiesBlock> {
  final activities = <ActivityEntity>[];
  String _query = '';

  void _sortActivities() {
    activities.clear();
    var stateActivities = BlocProvider.of<ActivitiesBloc>(context).activities;
    if (_query.trim().isNotEmpty) {
      stateActivities = stateActivities
          .where(
            (element) => element.name
                .toLowerCase()
                .contains(_query.trim().toLowerCase()),
          )
          .toList();
    }
    activities.addAll(stateActivities);

    activities.sort((a, b) => a.name.compareTo(b.name));
  }

  void _onQueryChanged(String text) {
    setState(() {
      _query = text;
      _sortActivities();
    });
  }

  void _activitiesListener(BuildContext context, ActivitiesState state) {
    if (state is ActivitiesLoadedState) {
      setState(() {
        _sortActivities();
      });
    }
  }

  void _onActivityPressed(BuildContext context, ActivityEntity activity) {
    final bloc = BlocProvider.of<ActivitiesBloc>(context);

    if (bloc.isActivityPicked(activity.id)) {
      bloc.add(UnselectActivityEvent(activity.id));
      BlocProvider.of<DayBloc>(context).add(RemoveActivityEvent(activity));
    } else {
      bloc.add(SelectActivityEvent(activity.id));
      BlocProvider.of<DayBloc>(context).add(AddActivityEvent(activity));
    }
  }

  void _onActivityLongPressed(
    BuildContext context,
    ActivityEntity activity,
  ) async {
    final newName = await openEditNameDialog(
      activity.name,
      delete: () => _deleteActivity(context, activity),
    );
    if (newName != null && newName != activity.name) {
      if (context.mounted) {
        BlocProvider.of<ActivitiesBloc>(context).add(
          ChangeActivityNameEvent(
            activityId: activity.id,
            newName: newName,
          ),
        );
      }
    }
  }

  void _deleteActivity(
    BuildContext context,
    ActivityEntity activity,
  ) async {
    if (await showConfirmDeleteDialog(DeleteDialogType.activity)) {
      if (context.mounted) {
        BlocProvider.of<ActivitiesBloc>(context).add(
          DeleteActivityEvent(activity.id),
        );
      }
    }
  }

  void _addActivity(BuildContext context) async {
    final name = await openCreateNameDialog();
    if (name != null) {
      if (context.mounted) {
        BlocProvider.of<ActivitiesBloc>(context).add(
          CreateActivityEvent(name),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesBloc, ActivitiesState>(
        listener: _activitiesListener,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySegmentTitle('activities'),
              Row(
                children: [
                  Expanded(
                    child: ActOrFoodSearchBar(onChanged: _onQueryChanged),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () => _addActivity(context),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                children: List<Widget>.generate(
                  activities.length,
                  (index) {
                    final activity = activities[index];

                    return ActivityItem(
                      activity: activity,
                      isSelected: BlocProvider.of<ActivitiesBloc>(context)
                          .isActivityPicked(activity.id),
                      onActivityLongPressed: () =>
                          _onActivityLongPressed(context, activity),
                      onActivityPressed: () =>
                          _onActivityPressed(context, activity),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
