import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';

class DayItem extends StatelessWidget {
  final DayEntity dayEntity;

  const DayItem({required this.dayEntity, super.key});

  Future<void> onDayPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      routeDayScreen,
      arguments: DayScreenParams(
        dateTime: dayEntity.date,
        day: dayEntity,
      ),
    );

    if (context.mounted) {
      BlocProvider.of<DaysListBloc>(context).add(FetchDaysListEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () => onDayPressed(context),
        title: Text(dayEntity.mood.name).tr(gender: 'masc'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat(
                'dd MMMM',
                'ru',
              ).format(dayEntity.date),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              dayEntity.date.year.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            )
          ],
        ),
        trailing: const Icon(
          Icons.arrow_right,
          size: 30,
        ),
      ),
    );
  }
}
