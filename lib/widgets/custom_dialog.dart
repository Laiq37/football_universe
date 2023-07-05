import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/gradient_background.dart';

class CustomDialog extends StatelessWidget {
  final double height;
  final double width;
  final double? titleSize ;
  final String dialogTitle;
  final List<Widget> child;

  const CustomDialog({required this.height, required this.width, this.titleSize, required this.dialogTitle, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeManager.getResponsiveWidth(15)),
            // height: SizeManager.getResponsiveWidth(150),
            //   width: SizeManager.getResponsiveWidth(260),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    SizeManager.getResponsiveWidth(SizeManager.medium),
                  ),
                  color: ColorManager.accent),
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GradientBackground(
                      height: SizeManager.getResponsiveWidth(40),
                      topLeft:
                          SizeManager.getResponsiveWidth(SizeManager.medium),
                      topRight:
                          SizeManager.getResponsiveWidth(SizeManager.medium),
                      child: Center(
                          child: Text(
                        dialogTitle,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.lightAccent, fontSize: titleSize),
                          textScaleFactor: SizeManager.getTextScaleFactor(context),
                      ))),
                  ...child
                ],
              ),
            ),
          ),
          Positioned(
              right: SizeManager.getResponsiveWidth(5),
              top: SizeManager.getResponsiveWidth(5),
              child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset(
                    SVG.cancel,
                    height: SizeManager.getResponsiveWidth(SizeManager.biggest),
                    width: SizeManager.getResponsiveWidth(SizeManager.biggest),
                  ))),
        ],
      ),
    );
  }
}
