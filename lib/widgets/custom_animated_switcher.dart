import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  final String uniqueId;
  final Widget child;
  const CustomAnimatedSwitcher(
      {required this.uniqueId, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        key: Key(uniqueId),
        duration: const Duration(milliseconds: 500),
        child: child);
  }
}
