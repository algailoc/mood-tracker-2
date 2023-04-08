import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/helpers/choose_date_dialog.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/days_list/day_item.dart';

class DaysListScreen extends StatelessWidget {
  const DaysListScreen({super.key});

  Future<void> _onAddPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    final days = BlocProvider.of<DaysListBloc>(context).days;
    final dates = days
        .map((e) => DateTime(
              e.date.year,
              e.date.month,
              e.date.day,
            ))
        .toList();

    final date = await showChooseDateDialog(
      context,
      disabledDays: dates,
    );
    if (date == null) return;

    navigator.pushNamed(
      routeDayScreen,
      arguments: DayScreenParams(dateTime: date),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DaysListBloc, DaysListState>(builder: (context, state) {
      if (state is DaysListPending && state.days.isEmpty) {
        return const Scaffold(
          appBar: _CustomAppBar(),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final days = state.days;

      return Scaffold(
        appBar: const _CustomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 30,
          child: IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) => DayItem(dayEntity: days[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: days.length,
          ),
        ),
      );
    });
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            // go to statistics
          },
          icon: Icon(
            Icons.bar_chart_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
