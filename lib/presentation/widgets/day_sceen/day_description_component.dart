import 'package:flutter/material.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayDescriptionComponent extends StatelessWidget {
  final String description;

  const DayDescriptionComponent(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySegmentTitle('other'),
        Text(description),
      ],
    );
  }
}
