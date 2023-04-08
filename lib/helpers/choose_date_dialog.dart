import 'package:flutter/material.dart';

Future<DateTime?> showChooseDateDialog(
  BuildContext context, {
  List<DateTime> disabledDays = const [],
}) async {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.fromMillisecondsSinceEpoch(0),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    selectableDayPredicate: (day) => disabledDays.contains(day),
  );
}
