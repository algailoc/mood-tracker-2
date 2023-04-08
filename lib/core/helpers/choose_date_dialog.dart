import 'package:flutter/material.dart';

Future<DateTime?> showChooseDateDialog(
  BuildContext context, {
  List<DateTime> disabledDays = const [],
}) async {
  final now = DateTime.now();
  final nowDate = DateTime(now.year, now.month, now.day);
  return showDatePicker(
    context: context,
    initialDate: now,
    firstDate: DateTime.fromMillisecondsSinceEpoch(0),
    lastDate: now,
    selectableDayPredicate: (day) =>
        !disabledDays.contains(day) || day == nowDate,
  );
}
