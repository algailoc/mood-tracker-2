import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/activity_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/common/edit_activity_dialog.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayActivitiesList extends StatefulWidget {
  final List<String> activitiesIds;

  const DayActivitiesList(this.activitiesIds, {super.key});

  @override
  State<DayActivitiesList> createState() => _DayActivitiesListState();
}

class _DayActivitiesListState extends State<DayActivitiesList> {
  final activities = <ActivityEntity>[];

  void _activitiesListener(BuildContext context, ActivitiesState state) {
    if (state is ActivitiesLoadedState && state.activities.isNotEmpty) {
      setState(() {
        final allActivities = state.activities;
        for (var id in widget.activitiesIds) {
          final activity = allActivities.where((element) => element.id == id);
          if (activity.isNotEmpty) {
            activities.add(activity.first);
          }
        }
        activities.sort((a, b) => a.name.compareTo(b.name));
      });
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
              const SizedBox(height: 12),
              Wrap(
                children: List.generate(
                  activities.length,
                  (index) {
                    final activity = activities[index];

                    return InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      highlightColor: Colors.pink.shade100,
                      onLongPress: () async {
                        final newName = await openEditNameDialog(activity.name);
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
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 3,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1),
                        ),
                        child: Text(activity.name),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
