import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_dialog.dart';

class ExceptionDialog extends StatelessWidget {
  final String title;
  final String message;
  const ExceptionDialog({required this.title, required this.message,super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
          height: SizeManager.getResponsiveWidth(150),
          width: SizeManager.getResponsiveWidth(250),
          titleSize: 18,
          dialogTitle: title,
          child: [
            Expanded(
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal:SizeManager.getResponsiveWidth(SizeManager.smaller)),
                    child: Text(
                                message,
                                style: Theme.of(context).textTheme.displayMedium,
                                textScaleFactor: SizeManager.getTextScaleFactor(context),
                              ),
                  ),
                ))
          ]);;
  }
}