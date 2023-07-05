import 'package:flutter/material.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/models/sport_match.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/res/helper_functions.dart';
import 'package:football_universe/widgets/custom_animated_switcher.dart';
import 'package:get/get.dart';

class MatchCard extends StatelessWidget {
  final SportMatch match;
  const MatchCard({required this.match, super.key});

  @override
  Widget build(BuildContext context) {
    final MatchesController controller = Get.find<MatchesController>();
    print(match.date);
    return Column(
      children: [
        SizedBox(
          height: SizeManager.getResponsiveWidth(105),
          width: SizeManager.deviceWidth,
          child: Card(
            color: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizeManager.getResponsiveWidth(SizeManager.small),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeManager.getResponsiveWidth(SizeManager.big),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeManager.getResponsiveWidth(SizeManager.small),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          HelpersFunctions.formatDate(match.date),
                          textScaleFactor:
                              SizeManager.getTextScaleFactor(context),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: ColorManager.lightAccent,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: SizeManager.deviceWidth * 0.1,
                      ),
                      Text(
                        HelpersFunctions.formatTime(match.date),
                        textScaleFactor:
                            SizeManager.getTextScaleFactor(context),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: ColorManager.lightAccent,
                                ),
                      ),
                      SizedBox(
                        width: SizeManager.deviceWidth * 0.1,
                      ),
                      // const Spacer(),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.isInFavorite(match.id)
                              ? controller.remove(match.id)
                              : controller.add(match),
                          child: SizedBox(
                            child: Obx(() {
                              return CustomAnimatedSwitcher(
                                uniqueId: match.id,
                                child: controller.favoriteMatchesId
                                        .contains(match.id)
                                    ? Image.asset(
                                        key: const ValueKey('favorite'),
                                        Images.favorite,
                                        height: SizeManager.getResponsiveWidth(
                                            SizeManager.bigger))
                                    : Image.asset(
                                        key: const ValueKey('not_favorite'),
                                        Images.notFavorite,
                                        height: SizeManager.getResponsiveWidth(
                                            SizeManager.bigger),
                                      ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeManager.getResponsiveWidth(SizeManager.small),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          match.home,
                          textScaleFactor:
                              SizeManager.getTextScaleFactor(context),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: SizeManager.big),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: SizeManager.deviceWidth * 0.1,
                      ),
                      Container(
                        height: SizeManager.getResponsiveHeight(4),
                        width: SizeManager.getResponsiveWidth(38),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                SizeManager.getResponsiveWidth(4),
                              ),
                            ),
                            color: ColorManager.lightAccent),
                      ),
                      SizedBox(
                        width: SizeManager.deviceWidth * 0.1,
                      ),
                      Expanded(
                        child: Text(
                          match.away,
                          textScaleFactor:
                              SizeManager.getTextScaleFactor(context),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: SizeManager.big),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
