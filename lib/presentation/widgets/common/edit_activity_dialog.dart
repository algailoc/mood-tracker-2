import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<String?> openEditNameDialog(String oldName) async {
  return SmartDialog.show(
    builder: (context) => _EditNameDialog(oldName),
  );
}

class _EditNameDialog extends StatefulWidget {
  final String oldName;

  const _EditNameDialog(this.oldName);

  @override
  State<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<_EditNameDialog> {
  late final TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.oldName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              right: 10,
              child: IconButton(
                onPressed: SmartDialog.dismiss,
                icon: Icon(
                  Icons.close,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  TextField(
                    controller: nameController,
                    maxLength: 40,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => SmartDialog.dismiss(
                      result: nameController.text.trim(),
                    ),
                    child: const Text(
                      'save',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
