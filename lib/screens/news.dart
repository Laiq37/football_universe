import 'package:flutter/material.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/exception_dialog.dart';
import 'package:football_universe/widgets/news_card.dart';
import 'package:football_universe/widgets/template.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class News extends StatefulWidget {
  final String newsTitle;
  const News({required this.newsTitle, Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late final NewsController newsController;

  showCustomDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return const ExceptionDialog(
            title: "Error fetching news data",
            message:
                "Sorry, we were unable to fetch the latest news data at this time. Please check your network connection and try again later.",
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsController = Get.find<NewsController>();
    Future.delayed(
        const Duration(milliseconds: 1000),
        () => newsController.get(
            DataSourceType.network,
            widget.newsTitle == ConstantStrings.mainNews
                ? NewsListType.main
                : NewsListType.daily)).catchError((err) {
      showCustomDialog();
    });
    Future.delayed(
        const Duration(milliseconds: 2000),
        () => newsController.getFavorites(
            DataSourceType.local, NewsListType.favorite));
  }

  @override
  Widget build(BuildContext context) {
    SizeManager.deviceWidth = MediaQuery.of(context).size.width;
    SizeManager.deviceHeight = MediaQuery.of(context).size.height;
    return HomeTemplate(
      appBartitle: widget.newsTitle,
      onFilterChange: () {
        try {
          newsController.get(
              DataSourceType.network,
              widget.newsTitle == ConstantStrings.mainNews
                  ? NewsListType.main
                  : NewsListType.daily,
                  true);
        } catch (err) {
          showCustomDialog();
        }finally{
            widget.newsTitle == ConstantStrings.mainNews
                  ? newsController.dailyNews.clear(): newsController.mainNews.clear();
            Get.find<MatchesController>().matchesList.clear();
        }
      },
      child: Obx(() {
        return newsController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                strokeWidth: 3,
                edgeOffset: 20,
                onRefresh: () => Future.delayed(
                  Duration.zero,
                  () => newsController.get(
                    DataSourceType.network,
                    widget.newsTitle == ConstantStrings.mainNews
                        ? NewsListType.main
                        : NewsListType.daily,
                    true,
                  ),
                ).catchError((err) {
                  showCustomDialog();
                }),
                child: ListView.builder(
                  key: PageStorageKey<String>(
                      widget.newsTitle == ConstantStrings.mainNews
                          ? 'main'
                          : 'daily'),
                  padding: EdgeInsets.zero,
                  itemCount: widget.newsTitle == ConstantStrings.mainNews
                      ? newsController.mainNews.length
                      : newsController.dailyNews.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () =>
                          context.pushNamed(ConstantStrings.newsDetail, extra: {
                            "news": widget.newsTitle == ConstantStrings.mainNews
                                ? newsController.mainNews[index]
                                : newsController.dailyNews[index]
                          }),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeManager.getResponsiveWidth(
                                SizeManager.big)),
                        child: NewsCard(
                          news: widget.newsTitle == ConstantStrings.mainNews
                              ? newsController.mainNews[index]
                              : newsController.dailyNews[index],
                        ),
                      )),
                  // separatorBuilder: (context, index) => SizedBox(
                  //   height: SizeManager.getResponsiveWidth(SizeManager.big),
                  // ),
                ),
              );
      }),
    );
  }
}
