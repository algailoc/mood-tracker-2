import 'package:flutter/material.dart';
import 'package:mood_tracker_2/presentation/screens/days_list_screen/days_list_screen.dart';

const routeDaysList = 'routeDaysList';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == routeDaysList) {
    return MaterialPageRoute(
      builder: (context) {
        return const DaysListScreen();
      },
    );
  }

  return null;
}
