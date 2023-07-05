import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_animated_switcher.dart';
import 'package:football_universe/widgets/gradient_background.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function() onLeadingTap;
  final Function()? onTrailingTap;
  final String? newsId;
  const CustomAppBar(
      {required this.title,
      required this.onLeadingTap,
      this.newsId,
      this.onTrailingTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeManager.getResponsiveWidth(SizeManager.medium)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onLeadingTap,
                child: title == ConstantStrings.newsDetail ||
                        title == ConstantStrings.calender
                    ? Icon(Icons.arrow_back_ios_new_rounded,
                        size:
                            SizeManager.getResponsiveWidth(SizeManager.biggest))
                    : SvgPicture.asset(
                        SVG.menu,
                        height:
                            SizeManager.getResponsiveWidth(SizeManager.biggest),
                      ),
              ),
              if(title != ConstantStrings.newsDetail)
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (title != ConstantStrings.calender &&
                  title != ConstantStrings.favorites)
                GestureDetector(
                  onTap: onTrailingTap,
                  child: title == ConstantStrings.newsDetail
                      //  ? Icon(Icons.star_rate_rounded, color: Colors.white38,  size: SizeManager.getResponsiveWidth(
                      //                           SizeManager.bigger),):
                      ? Obx(() {
                          return CustomAnimatedSwitcher(
                            uniqueId: newsId!,
                            child: !Get.find<NewsController>()
                                    .favoriteNewsId
                                    .contains(newsId)
                                ? Image.asset(
                                    key: const ValueKey('not_favorite'),
                                    Images.notFavorite,
                                    height: SizeManager.getResponsiveWidth(
                                        SizeManager.bigger))
                                : Image.asset(
                                    key: const ValueKey('favorite'),
                                    Images.favorite,
                                    height: SizeManager.getResponsiveWidth(
                                        SizeManager.bigger),
                                  ),
                          );
                        })
                      : SvgPicture.asset(
                          SVG.filter,
                          height: SizeManager.getResponsiveWidth(
                              SizeManager.bigger),
                        ),
                ),
              if (title == ConstantStrings.calender ||
                  title == ConstantStrings.favorites)
                Container()
            ]),
      ),
    );
  }
}
