import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/bloc/day_edit_bloc/day_edit_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class DescriptionBlock extends StatelessWidget {
  const DescriptionBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DaySegmentTitle('other'),
        BlocBuilder<DayEditBloc, DayEditState>(builder: (context, state) {
          if (state is DayEditInitedEvent) {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: TextField(
                controller: state.descriptionController,
                onChanged: (value) => BlocProvider.of<DayBloc>(context).add(
                  UpdateDescriptionEvent(value),
                ),
                maxLines: 6,
                minLines: 3,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}
