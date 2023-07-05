
import 'package:flutter/material.dart';
import 'package:football_universe/res/font_manager.dart';


ButtonStyle getButtonStyle(color, yPad, [xPad = 0.0]){
  return ElevatedButton.styleFrom(
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: xPad, vertical: yPad),
    backgroundColor: color,
    shape: const StadiumBorder()
  );
}

TextStyle _getTextStyle(
  String fontFamily,
    double fontSize , FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getMediumStyle({required String fontfamily, double fontSize = 12.0, required color}) {
  return _getTextStyle(
      fontfamily,
      fontSize, FontWeightManager.medium, color);
}

TextStyle getSemiBoldStyle({double fontSize = 12.0, required color}) {
  return _getTextStyle(
      FontFamily.inter,
      fontSize, FontWeightManager.medium, color);
}