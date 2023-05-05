import 'package:flutter/material.dart';

class SizedBoxSeparator extends StatelessWidget {
  final double height;

  const SizedBoxSeparator({this.height = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
