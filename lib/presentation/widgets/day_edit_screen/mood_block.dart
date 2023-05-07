import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/domain/entities/mood_entity.dart';
import 'package:mood_tracker_2/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/foods_bloc/foods_bloc.dart';

class MoodBlock extends StatelessWidget {
  const MoodBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _MoodItem(Mood.awful, state.dayEntity!.mood == Mood.awful),
          _MoodItem(Mood.bad, state.dayEntity!.mood == Mood.bad),
          _MoodItem(Mood.mediocre, state.dayEntity!.mood == Mood.mediocre),
          _MoodItem(Mood.good, state.dayEntity!.mood == Mood.good),
          _MoodItem(Mood.great, state.dayEntity!.mood == Mood.great),
        ],
      );
    });
  }
}

class _MoodItem extends StatelessWidget {
  final Mood mood;
  final bool isSelected;

  const _MoodItem(this.mood, this.isSelected);

  IconData _getMoodIcon() {
    switch (mood) {
      case Mood.awful:
        return Icons.sentiment_very_dissatisfied_outlined;
      case Mood.bad:
        return Icons.sentiment_dissatisfied_outlined;
      case Mood.mediocre:
        return Icons.sentiment_neutral_outlined;
      case Mood.good:
        return Icons.sentiment_satisfied_rounded;
      case Mood.great:
        return Icons.sentiment_very_satisfied_outlined;

      default:
        return Icons.sentiment_neutral_outlined;
    }
  }

  Color _getMoodColor() {
    const greyColor = Colors.grey;

    switch (mood) {
      case Mood.awful:
        return isSelected ? Colors.red.shade900 : greyColor;
      case Mood.bad:
        return isSelected ? Colors.red : greyColor;
      case Mood.mediocre:
        return isSelected ? Colors.grey.shade700 : greyColor;
      case Mood.good:
        return isSelected ? Colors.green.shade400 : greyColor;
      case Mood.great:
        return isSelected ? Colors.green.shade800 : greyColor;

      default:
        return isSelected ? Colors.grey.shade700 : greyColor;
    }
  }

  void _onMoodPressed(BuildContext context) {
    BlocProvider.of<DayBloc>(context).add(UpdateMoodEvent(mood));
    BlocProvider.of<ActivitiesBloc>(context)
        .add(ChangeMoodForActivitiesEvent(mood));
    BlocProvider.of<FoodsBloc>(context).add(ChangeMoodForFoodsEvent(mood));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: IconButton(
          onPressed: () => _onMoodPressed(context),
          icon: Icon(
            _getMoodIcon(),
            color: _getMoodColor(),
          ),
        ),
      ),
    );
  }
}
