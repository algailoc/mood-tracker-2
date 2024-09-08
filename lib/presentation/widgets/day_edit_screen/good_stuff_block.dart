import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mood_tracker_2/presentation/bloc/day_bloc/day_bloc.dart';
import 'package:mood_tracker_2/presentation/widgets/day_sceen/segment_title.dart';

class GoodStuffBlock extends StatelessWidget {
  const GoodStuffBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayBloc, DayState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DaySegmentTitle('goodStuff'),
          ),
          ...List.generate(state.dayEntity!.goodStuff.length + 1, (index) {
            if (index == state.dayEntity!.goodStuff.length) {
              return const _NewInput();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _GoodStuffItem(state.dayEntity!.goodStuff[index]),
            );
          }),
        ],
      );
    });
  }
}

class _GoodStuffItem extends StatelessWidget {
  final String text;

  const _GoodStuffItem(this.text);

  void copyText() async {
    await Clipboard.setData(ClipboardData(text: text));
    SmartDialog.showToast('textCopied'.tr());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: copyText,
      onLongPress: copyText,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.77,
            child: Text(
              text,
              softWrap: true,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => BlocProvider.of<DayBloc>(context).add(
              RemoveGoodStuffEvent(text),
            ),
            icon: Icon(
              Icons.delete_outline_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewInput extends StatefulWidget {
  const _NewInput();

  @override
  State<_NewInput> createState() => _NewInputState();
}

class _NewInputState extends State<_NewInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  void _onAddPressed() {
    if (controller.text.trim().isEmpty) {
      return;
    }
    BlocProvider.of<DayBloc>(context).add(AddGoodStuffEvent(controller.text));

    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 35,
          height: 30,
          child: IconButton(
            onPressed: _onAddPressed,
            icon: Icon(
              Icons.add,
              color: controller.text.trim().isNotEmpty
                  ? Colors.green
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 30,
            child: TextField(
              maxLength: 150,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                counterText: "",
              ),
              controller: controller,
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: IconButton(
            onPressed: () {
              controller.clear();
              setState(() {});
            },
            icon: Icon(
              Icons.close,
              size: 16,
              color: controller.text.trim().isNotEmpty
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
