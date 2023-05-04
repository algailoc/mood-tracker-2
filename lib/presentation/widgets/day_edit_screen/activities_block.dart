import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/helpers/confirm_delete_dialog.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/activity_item.dart';
import 'package:mood_tracker_2/presentation/widgets/common/edit_activity_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class EditActivitiesBlock extends StatefulWidget {
  const EditActivitiesBlock({super.key});

  @override
  State<EditActivitiesBlock> createState() => _EditActivitiesBlockState();
}

class _EditActivitiesBlockState extends State<EditActivitiesBlock> {
  final activities = <ActivityEntity>[];

  void _activitiesListener(BuildContext context, ActivitiesState state) {
    if (state is ActivitiesLoadedState && state.activities.isNotEmpty) {
      setState(() {
        activities.clear();
        activities.addAll(state.activities);
        activities.sort((a, b) => a.name.compareTo(b.name));
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesBloc, ActivitiesState>(
        listener: _activitiesListener,
        builder: (context, state) {
          if (state.activities.isEmpty) {
            return const SizedBox();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DaySegmentTitle('activities'),
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
