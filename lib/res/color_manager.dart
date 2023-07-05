import 'package:flutter/material.dart';

class ColorManager {
  static final Color primary = HexColor.fromHex('#29659A');
  static final Color accent = HexColor.fromHex('#DBEFFF');
  static final Color lightAccent = HexColor.fromHex('#FFFFFF');
  static final Color weekDayColor = HexColor.fromHex("ADADAD");
  static final Color dateColor = HexColor.fromHex("000000");
  static final Color settings = HexColor.fromHex("#214E78");
  static final Color disabled = Colors.grey[400]!;
  // static const Color activeTab = Color.fromRGBO(80, 177, 255, 0.5);
  static final Color activeTab =  HexColor.fromHex("#A5D6FD");
  static const Color nonActiveTab = Color.fromRGBO(80, 177, 255, 0.95);
  static final List<Color> appBarBackground = [HexColor.fromHex("#3890DA"), HexColor.fromHex("#2D70A9")];
}

extension HexColor on Color {
  static fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', "");
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
