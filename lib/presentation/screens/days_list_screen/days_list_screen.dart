import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/core/params.dart';
import 'package:mood_tracker_2/core/router.dart';
import 'package:mood_tracker_2/domain/entities/day_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/days_list_bloc/days_list_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/days_list/day_cell.dart';
import 'package:mood_tracker_2/core/helpers/choose_date_dialog.dart';
import 'package:mood_tracker_2/core/helpers/dates_helpers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DaysListScreen extends StatefulWidget {
  const DaysListScreen({super.key});

  @override
  State<DaysListScreen> createState() => _DaysListScreenState();
}

class _DaysListScreenState extends State<DaysListScreen> {
  int _index = 0;
  final scrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  void _changeIndex(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

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
      final months = getMonthsList(
        days.isNotEmpty ? days.first.date : DateTime.now(),
      ).reversed.toList();

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
            child: Column(
              children: [
                Text(
                  DateFormat('LLLL yyyy').format(months[_index]).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 350,
                  child: Row(
                    children: [
                      _NavigationButton(
                        forward: false,
                        controller: scrollController,
                        index: _index,
                        active: _index < months.length,
                        changeIndex: _changeIndex,
                      ),
                      Expanded(
                        child: _MonthsList(
                          scrollController: scrollController,
                          itemPositionsListener: itemPositionsListener,
                          months: months,
                          days: days,
                        ),
                      ),
                      _NavigationButton(
                        forward: true,
                        controller: scrollController,
                        index: _index,
                        active: _index > 0,
                        changeIndex: _changeIndex,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // body: SafeArea(
        //   child: ListView.separated(
        //     padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
        //     itemBuilder: (context, index) => DayItem(dayEntity: days[index]),
        //     separatorBuilder: (context, index) => const Divider(
        //       color: Colors.transparent,
        //       // height: 2,
        //     ),
        //     itemCount: days.length,
        //   ),
        // ),
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

class _MonthsList extends StatelessWidget {
  final ItemScrollController scrollController;
  final ItemPositionsListener itemPositionsListener;
  final List<DateTime> months;
  final List<DayEntity> days;

  const _MonthsList({
    required this.scrollController,
    required this.itemPositionsListener,
    required this.months,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: scrollController,
      itemPositionsListener: itemPositionsListener,
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemCount: months.length,
      itemBuilder: (_, index) {
        final monthDate = months[index];
        final daysList = getNumberOfDays(monthDate);

        return SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Center(
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
              children: List.generate(daysList, (index) {
                final date = DateTime(
                  monthDate.year,
                  monthDate.month,
                  index + 1,
                );
                final day = days.cast<DayEntity?>().firstWhere(
                      (el) => el!.date == date,
                      orElse: () => null,
                    );

                return DayCell(date: date, day: day);
              }),
            ),
          ),
        );
      },
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final bool forward;
  final ItemScrollController controller;
  final int index;
  final bool active;
  final void Function(int) changeIndex;

  const _NavigationButton({
    required this.forward,
    required this.controller,
    required this.index,
    required this.active,
    required this.changeIndex,
  });

  void _onPressed(BuildContext context) {
    if (active) {
      if (forward) {
        controller.scrollTo(
          index: index - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut,
        );
        changeIndex(index - 1);
      } else {
        controller.scrollTo(
          index: index + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut,
        );
        changeIndex(index + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: forward ? 0 : 8, left: !forward ? 0 : 8),
      child: SizedBox(
        width: 30,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onPressed(context),
          child: Center(
            child: Icon(
              forward ? Icons.arrow_right_rounded : Icons.arrow_left_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
