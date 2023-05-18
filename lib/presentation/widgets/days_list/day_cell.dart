import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/constants.dart';
import 'package:mood_tracker_2/core/helpers/mood_helpers.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';

class DayCell extends StatelessWidget {
  final DateTime date;
  final DayEntity? day;

  const DayCell({required this.date, required this.day, super.key});

  Future<void> _onDayPressed(BuildContext context) async {
    final today = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    if (date.isAfter(today)) {
      return;
    }
    if (day != null) {
      await Navigator.of(context).pushNamed(
        routeDayScreen,
        arguments: DayScreenParams(
          dateTime: day!.date,
          day: day,
        ),
      );

      if (context.mounted) {
        BlocProvider.of<DaysListBloc>(context).add(FetchDaysListEvent());
      }
    } else {
      await Navigator.of(context).pushNamed(
        routeEditDayScreen,
        arguments: DayScreenParams(
          dateTime: date,
        ),
      );

      if (context.mounted) {
        BlocProvider.of<DaysListBloc>(context).add(FetchDaysListEvent());
      }
    }
  }

  bool _isToday() {
    final today = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
    return today == date;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDayPressed(context),
      child: Container(
        width: calendarCellSize,
        height: calendarCellSize,
        decoration: BoxDecoration(
          color: day == null ? Colors.transparent : getMoodColor(day!.mood),
          border: Border.all(
            color: _isToday()
                ? Theme.of(context).colorScheme.onBackground
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 6,
                left: 8,
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: day == null
                        ? Theme.of(context).colorScheme.onBackground
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (day != null)
                Positioned(
                  bottom: 6,
                  right: 8,
                  child: Icon(
                    getMoodIcon(day!.mood),
                    size: 16,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
