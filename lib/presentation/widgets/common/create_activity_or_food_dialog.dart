import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<String?> openCreateNameDialog() async {
  return SmartDialog.show(
    builder: (context) => _CreateDialog(),
  );
}

class _CreateDialog extends StatefulWidget {
  const _CreateDialog();

  @override
  State<_CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<_CreateDialog> {
  final _nameController = TextEditingController();

  void _onCreatePressed(BuildContext context) async {
    SmartDialog.dismiss(result: _nameController.text.trim());
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
                    controller: _nameController,
                    maxLength: 40,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => SmartDialog.dismiss(),
                        child: const Text(
                          'cancel',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ).tr(),
                      ),
                      TextButton(
                        onPressed: _nameController.text.trim().isEmpty
                            ? null
                            : () => _onCreatePressed(context),
                        child: const Text(
                          'save',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ).tr(),
                      ),
                    ],
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
