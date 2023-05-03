import 'package:flutter/material.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DayBadStuffComponent extends StatelessWidget {
  final List<String> badStuff;

  const DayBadStuffComponent(this.badStuff, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySegmentTitle('badStuff'),
        ...List.generate(badStuff.length, (index) {
          final text = badStuff[index];

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == badStuff.length - 1 ? 0 : 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '\u2022',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: const TextStyle(height: 1.55),
                  ),
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
