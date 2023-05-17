int getNumberOfDays(DateTime date) {
  final nextMonth = date.month == 12
      ? DateTime(date.year + 1, 1, 1)
      : DateTime(date.year, date.month + 1, 1);

  return nextMonth.difference(date).inDays;
}

const yearsBeforeDate = 1;

List<DateTime> getMonthsList(DateTime last) {
  final firstDate = DateTime(last.year - yearsBeforeDate, last.month - 1, 1);
  final result = <DateTime>[];
  var newDate = firstDate;
  while (newDate.year != last.year || newDate.month != last.month + 1) {
    result.add(newDate);
    newDate = newDate.month == 12
        ? DateTime(newDate.year + 1, 1, 1)
        : DateTime(newDate.year, newDate.month + 1, 1);
  }

  return result;
}
