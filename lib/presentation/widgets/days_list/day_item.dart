import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';

class DayItem extends StatelessWidget {
  final DayEntity dayEntity;

  const DayItem({required this.dayEntity, super.key});

  Future<void> onDayPressed(BuildContext context) async {
    Navigator.of(context).pushNamed(
      routeDayScreen,
      arguments: DayScreenParams(
        dateTime: dayEntity.date,
        day: dayEntity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        splashColor: Theme.of(context).colorScheme.primary,
        onTap: () => onDayPressed(context),
        title: Text(dayEntity.mood.name).tr(),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat(dayEntity.date.year == DateTime.now().year
                      ? 'DD.MM'
                      : 'DD.MM.yyyy')
                  .format(dayEntity.date),
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
