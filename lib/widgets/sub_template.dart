//for sub screens
import 'package:flutter/material.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/models/news.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SubTemplate extends StatelessWidget {
  final String appBartitle;
  final News? news;
  final NewsController? newsController;
  final Widget child;
  const SubTemplate(
      {required this.appBartitle,
      this.news,
      this.newsController,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: appBartitle,
              onLeadingTap: () => context.pop(),
              newsId: news?.id,
              onTrailingTap: appBartitle == ConstantStrings.calender
                  ? null
                  : () {
                      !newsController!.isInFavorite(news!.id)
                          ? newsController!.add(news!)
                          : newsController!.remove(news!.id);
                    },
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
