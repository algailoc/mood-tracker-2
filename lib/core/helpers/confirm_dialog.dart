import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<bool> showConfirmDialog() async {
  final result = await SmartDialog.show(
    builder: (context) => AlertDialog(
      title: const Text(
        'leaveWithoutSaveConfirmation',
        style: TextStyle(),
      ).tr(),
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
            'leave',
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
