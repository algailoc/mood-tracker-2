import 'package:flutter/material.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/presentation/screens/day_edit_screen/day_edit_screen.dart';
import 'package:mood_tracker_2/presentation/screens/day_screen/day_screen.dart';
import 'package:mood_tracker_2/presentation/screens/days_list_screen/days_list_screen.dart';
import 'package:mood_tracker_2/presentation/screens/statistics_screen/statistics_screen.dart';

const routeDaysList = '/routeDaysList';
const routeDayScreen = '/routeDayScreen';
const routeEditDayScreen = '/routeEditDayScreen';
const routeStatistics = '/routeStatistics';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == routeDaysList) {
    return MaterialPageRoute(
      builder: (context) {
        return const DaysListScreen();
      },
    );
  } else if (settings.name == routeDayScreen) {
    return MaterialPageRoute(
      builder: (context) {
        return DayScreen(
          params: settings.arguments as DayScreenParams,
        );
      },
    );
  } else if (settings.name == routeEditDayScreen) {
    return MaterialPageRoute(
      builder: (context) {
        return DayEditScreen(
          settings.arguments as DayScreenParams,
        );
      },
    );
  } else if (settings.name == routeStatistics) {
    return MaterialPageRoute(
      builder: (context) {
        return const StatisticsScreen();
      },
    );
  }

  return null;
}
