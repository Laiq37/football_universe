import 'package:flutter/material.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/gradient_background.dart';
import 'package:football_universe/widgets/settings.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer({required this.scaffoldKey,super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map> items = [
      {
        'icon': Images.mainNews,
        'title': ConstantStrings.mainNews,
        "onTap": () {
          context.pushReplacementNamed(ConstantStrings.news);
        },
      },
      {
        'icon': Images.dailyNews,
        'title': ConstantStrings.dailyNews,
        "onTap": () {
          context.pushReplacementNamed(ConstantStrings.dailyNews,
              params: {"news_title": ConstantStrings.dailyNews});
        },
      },
      {
        'icon': Images.matches,
        'title': ConstantStrings.matches,
        "onTap": () {
          context.pushReplacementNamed(ConstantStrings.matches);
        },
      },
      {
        'icon': Images.favorites,
        'title': ConstantStrings.favorites,
        "onTap": () {
          context.pushReplacementNamed(ConstantStrings.favorites);
        },
      },
      {
        'icon': Images.settings,
        'title': ConstantStrings.settings,
        "onTap": ()async {
          //show popup
          await showDialog(barrierDismissible: false, context: context, builder: (context) => const Settings(),);
        },
      }
    ];

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      width: SizeManager.deviceWidth * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientBackground(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => scaffoldKey.currentState!.closeDrawer(),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ...items
                    .map((item) => Padding(
                          padding: EdgeInsets.only(
                              top: SizeManager.getResponsiveWidth(20.0),
                              left: SizeManager.getResponsiveWidth(20)),
                          child: GestureDetector(
                            onTap: item["onTap"],
                            child: Row(
                              children: [
                                // item['title'] == "Settings"
                                //     ? Icon(
                                //         Icons.settings,
                                //         color: ColorManager.settings,
                                //         size: SizeManager.getResponsiveWidth(
                                //             SizeManager.bigger),
                                //       )
                                //     : 
                                    Image.asset(item['icon'],
                                        height: SizeManager.getResponsiveWidth(
                                            SizeManager.biggest)),
                                SizedBox(
                                  width: SizeManager.getResponsiveWidth(
                                      SizeManager.biggest),
                                ),
                                Text(
                                  item['title'],
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  textScaleFactor:
                                      SizeManager.getTextScaleFactor(context),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
