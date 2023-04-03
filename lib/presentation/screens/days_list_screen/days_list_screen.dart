import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/days_list/day_item.dart';

class DaysListScreen extends StatelessWidget {
  const DaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DaysListBloc, DaysListState>(builder: (context, state) {
      if (state is DaysListPending) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final days = state.days;

      return Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
          itemBuilder: (context, index) => DayItem(dayEntity: days[index]),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: days.length,
        ),
      );
    });
  }
}
