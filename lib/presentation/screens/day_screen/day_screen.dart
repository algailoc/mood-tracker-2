import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/get_it.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';

class DayScreen extends StatelessWidget {
  final DayEntity? day;

  const DayScreen({required this.day, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DayBloc>(
          create: (context) => getIt<DayBloc>()
            ..add(
              InitDayEvent(
                date: day?.date ?? DateTime.now(),
                day: day,
              ),
            ),
        ),
        BlocProvider<ActivitiesBloc>(
            create: (context) => getIt<ActivitiesBloc>()),
        BlocProvider<FoodsBloc>(create: (context) => getIt<FoodsBloc>()),
      ],
      child: BlocBuilder<DayBloc, DayState>(
        builder: (context, state) => const Scaffold(),
      ),
    );
  }
}
