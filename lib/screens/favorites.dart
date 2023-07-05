import 'package:flutter/material.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_clipper.dart';
import 'package:football_universe/widgets/match_card.dart';
import 'package:football_universe/widgets/news_card.dart';
import 'package:football_universe/widgets/template.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final List favoriteTabs = [ConstantStrings.news, ConstantStrings.matches];
  late final NewsController newsController;
  late final MatchesController matchesController;
  @override
  void initState() {
    super.initState();
    newsController = Get.find<NewsController>();
    matchesController = Get.find<MatchesController>();
  }
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      appBartitle: ConstantStrings.favorites,
      child: Column(
        children: [
          Container(
            color: ColorManager.nonActiveTab,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    left: index * (SizeManager.deviceWidth * 0.5),
                    child: ClipPath(
                      clipper: CustomShapeClipper(
                          bottomRight: index != 1 ? true : false,
                          topLeft: index != 0 ? true : false,
                          diagonal: 10),
                      child: Container(
                        color: ColorManager.lightAccent,
                        child: Container(
                          width: SizeManager.deviceWidth * 0.5 +
                              (SizeManager.getResponsiveWidth(10)),
                          height: SizeManager.getResponsiveWidth(40),
                          color: ColorManager.activeTab,
                        ),
                      ),
                    )),
                Row(
                  children: [
                    for (int i = 0; i < favoriteTabs.length; i++)
                      GestureDetector(
                        onTap: () {
                          if(index == i)return;
                          setState(() {
                            index = i;
                          });
                          if(favoriteTabs[index] == ConstantStrings.matches && matchesController.favoriteMatches.isEmpty)matchesController.get(DataSourceType.local);
                        },
                        child: Container(
                          width: SizeManager.deviceWidth * 0.5,
                          height: SizeManager.getResponsiveWidth(40),
                          color: null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                favoriteTabs[i],
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: SizeManager.getResponsiveWidth(
                                          SizeManager.bigger),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeManager.getResponsiveWidth(SizeManager.big),
          ),
          Expanded(
              child: Obx(
                ()=> ListView.separated(
                    itemBuilder: (context, i) =>
                        index == 0 ? GestureDetector(onTap: () => context.pushNamed(ConstantStrings.newsDetail, extra: {
                            "news": newsController.favoriteNews[i],
                          }), child: NewsCard(news: newsController.favoriteNews[i],)) : MatchCard(match: matchesController.favoriteMatches[i],),
                    separatorBuilder: (context, index) => SizedBox(
                          height: SizeManager.getResponsiveWidth(SizeManager.big),
                        ),
                    itemCount: index == 0 ? newsController.favoriteNews.length : matchesController.favoriteMatches.length),
              ))
       
        ],
      ),
    );
  }
}
