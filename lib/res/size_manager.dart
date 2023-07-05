import 'dart:math';

import 'package:flutter/material.dart';

class SizeManager {
  static late double deviceWidth;
  static late double deviceHeight;

  static double getTextScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    double val = (deviceWidth / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
  static const double smaller = 8.0;
  static const double small = 10.0;
  static const double medium = 16.0;
  static const double big = 20.0;
  static const double bigger = 20.0;
  static const double biggest = 24.0;

  static double getResponsiveWidth(double size) => size * deviceWidth / 360.0;
  static double getResponsiveHeight(double size) => size * deviceHeight / 616.0;
}
