import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/font_manager.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/res/style_manager.dart';
import 'package:flutter/material.dart';

//bodySize 10
// headline1Size 16
// headline2Size 20
// titleSize 24

ThemeData getAppTheme() => ThemeData(
    primaryColor: ColorManager.primary,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ColorManager.primary,
      secondary: ColorManager.accent,
    ),
    cardTheme: CardTheme(
        color: ColorManager.accent,
        margin: EdgeInsets.zero,
        elevation: 4,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.75),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              SizeManager.small
              // SizeManager.getResponsiveWidth(SizeManager.small),
            ),
            bottomRight: Radius.circular(
              SizeManager.small
              // SizeManager.getResponsiveWidth(SizeManager.small),
            ),
          ),
        )),
    splashColor: ColorManager.accent, //rippleColor
    iconTheme: IconThemeData(
        size: SizeManager.biggest, color: ColorManager.lightAccent),
    textTheme: TextTheme(
      titleMedium: getMediumStyle(
          fontfamily: FontFamily.inter,
          fontSize: SizeManager.biggest,
          color: ColorManager.lightAccent),
      titleLarge: getSemiBoldStyle(
          fontSize: SizeManager.biggest, color: ColorManager.lightAccent),
      headlineMedium: getSemiBoldStyle(
          fontSize: SizeManager.big, color: ColorManager.primary),
      headlineSmall: getSemiBoldStyle(
          fontSize: SizeManager.medium, color: ColorManager.primary),
      displaySmall: getMediumStyle(
          fontfamily: FontFamily.inter,
          fontSize: SizeManager.small,
          color: ColorManager.primary),
      displayMedium: getMediumStyle(
          fontfamily: FontFamily.inter,
          fontSize: SizeManager.medium,
          color: ColorManager.primary),
      labelSmall: getSemiBoldStyle(
          fontSize: SizeManager.small, color: ColorManager.dateColor),
      labelMedium: getMediumStyle(
          fontfamily: FontFamily.inter,
          fontSize: SizeManager.medium,
          color: ColorManager.primary),
      labelLarge: getMediumStyle(
          fontfamily: FontFamily.roboto,
          fontSize: SizeManager.big,
          color: ColorManager.primary),
    ));
