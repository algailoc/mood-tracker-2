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
    return ListTile(
      title: Text(dayEntity.mood.name).tr(),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('DD.MM').format(dayEntity.date),
          ),
          Text(
            dayEntity.date.year.toString(),
          )
        ],
      ),
      trailing: IconButton(
        onPressed: () => onDayPressed(context),
        icon: const Icon(Icons.arrow_right),
      ),
    );
  }
}
