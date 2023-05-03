import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<bool> showConfirmDialog() async {
  final result = await SmartDialog.show(
    builder: (context) => const SizedBox(),
  );

  return result ?? false;
}
