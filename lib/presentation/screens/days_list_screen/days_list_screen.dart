import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/days_list/day_item.dart';
import 'package:mood_tracker_2/core/helpers/choose_date_dialog.dart';

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

    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month, now.day);
    final todayDays = days.where((element) => element.date == nowDate);

    // Проверка на случай того, что это уже заполненный сегодняшний день
    // Нужна, потому что метод [showDatePicker] требует, чтобы изначальное число было активным
    if (date == nowDate && todayDays.isNotEmpty) {
      await navigator.pushNamed(
        routeDayScreen,
        arguments: DayScreenParams(
          dateTime: todayDays.first.date,
          day: todayDays.first,
        ),
      );

      if (context.mounted) {
        BlocProvider.of<DaysListBloc>(context).add(FetchDaysListEvent());
      }

      return;
    }

    await navigator.pushNamed(
      routeEditDayScreen,
      arguments: DayScreenParams(dateTime: date),
    );

    if (context.mounted) {
      BlocProvider.of<DaysListBloc>(context).add(FetchDaysListEvent());
    }
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
            tooltip: const Text('addDay').tr().data,
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
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            itemBuilder: (context, index) => DayItem(dayEntity: days[index]),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
              // height: 2,
            ),
            itemCount: days.length,
          ),
        ),
      );
    });
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar();

  Future<void> _goToStatistics(BuildContext context) async {
    Navigator.pushNamed(context, routeStatistics);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Mood Tracker',
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          tooltip: const Text('statistics').tr().data,
          onPressed: () => _goToStatistics(context),
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
