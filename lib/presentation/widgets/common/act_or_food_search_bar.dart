import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ActOrFoodSearchBar extends StatelessWidget {
  final void Function(String) onChanged;

  ActOrFoodSearchBar({required this.onChanged, super.key});

  final FocusNode _inputFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 30,
        alignment: Alignment.centerLeft,
        child: TextField(
          focusNode: _inputFocus,
          onChanged: onChanged,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintText: 'enterName'.tr(),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
    // return Center(
    //   child: Container(
    //     margin: const EdgeInsets.only(bottom: 6),
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     width: MediaQuery.of(context).size.width * 0.9,
    //     height: 30,
    //     alignment: Alignment.centerLeft,
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         width: 1,
    //         color: _inputFocus.hasFocus ? Colors.pink : Colors.black,
    //       ),
    //       borderRadius: BorderRadius.circular(6),
    //     ),
    //     child: TextField(
    //       focusNode: _inputFocus,
    //       onChanged: onChanged,
    //       decoration: InputDecoration(
    //         isCollapsed: true,
    //         hintText: 'enterName'.tr(),
    //         border: InputBorder.none,
    //       ),
    //     ),
    //   ),
    // );
  }
}
