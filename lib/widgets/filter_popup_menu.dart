import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_universe/controllers/app_controller.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_animated_switcher.dart';
import 'package:get/get.dart';

class FilterPopupMenu extends StatefulWidget {
  final Function() onApplyFilters;
  const FilterPopupMenu({required this.onApplyFilters, super.key});

  @override
  State<FilterPopupMenu> createState() => _FilterPopupMenuState();
}

class _FilterPopupMenuState extends State<FilterPopupMenu> {
  late final AppController appController;

  @override
  void initState() {
    super.initState();
    appController = Get.find<AppController>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // height: SizeManager.getResponsiveWidth(200),
        width: SizeManager.getResponsiveWidth(157),
        child: Card(
          color: ColorManager.lightAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeManager.getResponsiveWidth(SizeManager.small)),
            child: Column(
              children: [
                ...ConstantStrings.sportList
                    .map((sport) => Padding(
                          padding: EdgeInsets.only(
                              top: SizeManager.getResponsiveWidth(
                                  SizeManager.small)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  appController.setFilters(sport);
                                  SnackBar snackBar = SnackBar(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    content: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              SizeManager.getResponsiveWidth(
                                                  SizeManager.big),
                                                  vertical: SizeManager.getResponsiveWidth(
                                                  12),
                                                  ),
                                      width: SizeManager.deviceWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(SizeManager.small), topRight: Radius.circular(SizeManager.small)),
                                          gradient: LinearGradient(
                                              colors: ColorManager
                                                  .appBarBackground)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Apply filters?',
                                            // textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color: ColorManager.accent),
                                            textScaleFactor:
                                                SizeManager.getTextScaleFactor(
                                                    context),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                    Get.find<AppController>().showPopupMenu.value= false;
                                                widget.onApplyFilters();
                                              },
                                              child: Text(
                                                'Yes',
                                                // textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                        color: ColorManager
                                                            .accent),
                                                textScaleFactor: SizeManager
                                                    .getTextScaleFactor(
                                                        context),
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: Obx(() {
                                  return CustomAnimatedSwitcher(
                                    uniqueId: sport,
                                    child: appController.activeFilters
                                            .contains(sport)
                                        ? SvgPicture.asset(
                                            SVG.switchEnable,
                                            key: const ValueKey('enable'),
                                          )
                                        : SvgPicture.asset(
                                            SVG.switchDisable,
                                            key: const ValueKey('disable'),
                                          ),
                                  );
                                }),
                              ),
                              SizedBox(
                                width: SizeManager.getResponsiveWidth(
                                    SizeManager.small),
                              ),
                              Text(
                                sport,
                                textScaleFactor:
                                    SizeManager.getTextScaleFactor(context),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                SizedBox(
                  height: SizeManager.getResponsiveWidth(SizeManager.small),
                )
              ],
            ),
          ),
        ));
  }
}
