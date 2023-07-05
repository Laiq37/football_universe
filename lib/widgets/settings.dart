import 'package:flutter/material.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/gradient_background.dart';
import 'package:football_universe/widgets/custom_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()..loadRequest(Uri.parse(ConstantStrings.privacyPolicyUrl));
  }
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        height: SizeManager.getResponsiveWidth(150),
        width: SizeManager.getResponsiveWidth(250),
        dialogTitle: ConstantStrings.settings,
        child: [
          SizedBox(
            height: SizeManager.getResponsiveWidth(30),
          ),
          GestureDetector(
            onTap: () async{
              await showDialog(
                barrierDismissible: false,
                context: context, builder: (context)=>
              CustomDialog(height: SizeManager.deviceHeight*.9, width: SizeManager.deviceWidth, dialogTitle: ConstantStrings.privacy_policy, child: [Expanded(child: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(SizeManager.getResponsiveWidth(SizeManager.medium)),bottomRight: Radius.circular(SizeManager.getResponsiveWidth(SizeManager.medium))),
                child: WebViewWidget(controller: controller,))),]));
            },
            child: GradientBackground(
                height: 40,
                width: SizeManager.getResponsiveWidth(200),
                topLeft: SizeManager.getResponsiveWidth(30),
                topRight: SizeManager.getResponsiveWidth(30),
                bottomLeft: SizeManager.getResponsiveWidth(30),
                bottomRight: SizeManager.getResponsiveWidth(30),
                child: Center(
                    child: Text(
                  "Privacy Policy",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: ColorManager.lightAccent),
                  textScaleFactor: SizeManager.getTextScaleFactor(context),
                ))),
          )
        ]);
  }
}
