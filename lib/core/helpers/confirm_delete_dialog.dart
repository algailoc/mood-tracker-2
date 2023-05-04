import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum DeleteDialogType { activity, food, day }

Future<bool> showConfirmDeleteDialog(DeleteDialogType type) async {
  String getTitle() {
    switch (type) {
      case DeleteDialogType.activity:
        return 'confrimDeleteAct';
      case DeleteDialogType.food:
        return 'confrimDeleteFood';
      case DeleteDialogType.day:
        return 'confrimDeleteDay';

      default:
        return '';
    }
  }

  final result = await SmartDialog.show(
    builder: (context) => AlertDialog(
      title: Text(getTitle()).tr(),
      actions: [
        TextButton(
          onPressed: () => SmartDialog.dismiss(result: false),
          child: const Text(
            'cancel',
            style: TextStyle(
              fontSize: 16,
            ),
          ).tr(),
        ),
        TextButton(
          onPressed: () => SmartDialog.dismiss(result: true),
          child: const Text(
            'delete',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ).tr(),
        ),
      ],
    ),
  );

  return result ?? false;
}
