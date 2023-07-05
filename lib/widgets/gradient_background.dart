import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:football_universe/res/color_manager.dart';

class GradientBackground extends StatelessWidget {
  final double? height;
  final Widget child;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final double? width;
  const GradientBackground(
      {this.height = 56,
      this.bottomLeft = 0,
      this.bottomRight = 0,
      this.topLeft = 0,
      this.topRight = 0,
      this.width,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: ColorManager.appBarBackground, stops: const [0.0, 1.0]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomLeft: Radius.circular(bottomLeft),
              bottomRight: Radius.circular(bottomRight))),
      child: child,
    );
  }
}
