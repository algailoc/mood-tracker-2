import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';

class DayItem extends StatelessWidget {
  final DayEntity dayEntity;

  const DayItem({required this.dayEntity, super.key});

  Future<void> onDayPressed(BuildContext context) async {
    Navigator.of(context).pushNamed(routeDayScreen, arguments: dayEntity);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        dayEntity.mood.toString(),
      ).tr(),
      leading: Text(
        DateFormat('dd.mm.yyyy').format(dayEntity.date),
      ),
      trailing: IconButton(
        onPressed: () => onDayPressed(context),
        icon: const Icon(Icons.arrow_right),
      ),
    );
  }
}
