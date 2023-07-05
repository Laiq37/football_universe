import 'package:flutter/material.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/res/color_manager.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_clipper.dart';
import 'package:football_universe/widgets/exception_dialog.dart';
import 'package:football_universe/widgets/match_card.dart';
import 'package:football_universe/widgets/template.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  late final MatchesController matchesController;

  showCustomDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return const ExceptionDialog(
            title: "Error fetching match data",
            message:
                "Sorry, we were unable to fetch the latest match data at this time. Please check your network connection and try again later.",
          );
        });
  }

  @override
  void initState() {
    super.initState();
    matchesController = Get.find<MatchesController>();
    if (matchesController.favoriteMatches.isEmpty)
      matchesController.get(DataSourceType.local);
    matchesController
        .get(
      DataSourceType.network,
    )
        .catchError((err) {
      showCustomDialog();
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
        appBartitle: ConstantStrings.matches,
        onFilterChange: () {
          try {
            matchesController.get(DataSourceType.network, init: true);
          } catch (err) {
            showCustomDialog();
          } finally {
            Get.find<NewsController>()
              ..dailyNews.clear()
              ..mainNews.clear();
          }
        },
        child: Column(
          children: [
            Container(
              color: ColorManager.nonActiveTab,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Obx(() {
                    return Positioned(
                        left: matchesController.selectedTab.value *
                            (SizeManager.deviceWidth * 0.2),
                        child: ClipPath(
                          clipper: CustomShapeClipper(
                              bottomRight:
                                  matchesController.selectedTab.value != 4
                                      ? true
                                      : false,
                              topLeft: matchesController.selectedTab.value != 0
                                  ? true
                                  : false),
                          child: Container(
                            color: ColorManager.lightAccent,
                            child: Container(
                              width: SizeManager.deviceWidth * 0.2 +
                                  (SizeManager.getResponsiveWidth(10)),
                              height: SizeManager.getResponsiveWidth(40),
                              color: ColorManager.activeTab,
                            ),
                          ),
                        ));
                  }),
                  Obx(
                    () => Row(
                      children: [
                        for (int i = 0;
                            i <= matchesController.selectedDates.length;
                            i++)
                          GestureDetector(
                            onTap: () {
                              //not allow to tap on active tab
                              if (matchesController.selectedTab.value == i &&
                                  i != matchesController.selectedDates.length)
                                return;
                              matchesController.selectedTab.value = i;
                              if (matchesController.selectedTab.value == 4) {
                                context.pushNamed(ConstantStrings.calender);
                                return;
                              }
                              matchesController
                                  .get(DataSourceType.network)
                                  .catchError((err) {
                                showCustomDialog();
                              });
                            },
                            child: Container(
                              width: SizeManager.deviceWidth * 0.2,
                              height: SizeManager.getResponsiveWidth(40),
                              color: null,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  i == 4
                                      ? Image.asset(
                                          Images.calender,
                                          height:
                                              SizeManager.getResponsiveWidth(
                                                  SizeManager.bigger),
                                          color: matchesController
                                                      .selectedTab.value ==
                                                  4
                                              ? null
                                              : Colors.white70,
                                        )
                                      : Text(
                                          matchesController.selectedDates[i].day
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontSize: SizeManager
                                                    .getResponsiveWidth(
                                                        SizeManager.bigger),
                                                color: matchesController
                                                            .selectedTab
                                                            .value ==
                                                        i
                                                    ? null
                                                    : Colors.white70,
                                              ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeManager.getResponsiveWidth(SizeManager.big),
            ),
            Expanded(
              child: Obx(() {
                return matchesController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => Future.delayed(
                            Duration.zero,
                            () => matchesController.selectedTab.value == 4
                                ? null
                                : matchesController
                                    .get(DataSourceType.network)),
                        child: ListView.separated(
                          itemCount: matchesController.matchesList.length,
                          itemBuilder: (context, ind) => MatchCard(
                            match: matchesController.matchesList[ind],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height:
                                SizeManager.getResponsiveWidth(SizeManager.big),
                          ),
                        ),
                      );
              }),
            ),
          ],
        )
        // Center(
        // child:
        //   TextButton(
        //     onPressed: () => context.pushNamed(ConstantStrings.calender),
        //     child: Text(ConstantStrings.calender),
        //   ),
        // ),
        );
  }
}
