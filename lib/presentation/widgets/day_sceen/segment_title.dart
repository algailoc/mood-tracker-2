import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DaySegmentTitle extends StatelessWidget {
  final String title;

  const DaySegmentTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey.shade800,
      ),
    ).tr();
  }
}
