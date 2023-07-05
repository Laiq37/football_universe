import 'package:flutter/material.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/models/news.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_cached_image.dart';
import 'package:football_universe/widgets/sub_template.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  final News news;
  const NewsDetail({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return SubTemplate(
        appBartitle: ConstantStrings.newsDetail,
        news: news,
        newsController: Get.find<NewsController>(),
        child: Center(
          child: ListView(
            children: [
              CustomCachedImage(
                id:news.id,
                imageUrl: news.image,
                width: SizeManager.deviceWidth,
                height: SizeManager.getResponsiveHeight(184),
              ),
              Padding(
                padding: EdgeInsets.all(
                  SizeManager.getResponsiveWidth(SizeManager.small),
                ),
                child: Text(
                  news.title,
                  // "Victory over the third division club in thesecond friendly match of the preseason"
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize:
                          SizeManager.getResponsiveWidth(SizeManager.big)),
                  textScaleFactor: SizeManager.getTextScaleFactor(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  SizeManager.getResponsiveWidth(SizeManager.small),
                ),
                child: Html(
                  data:news.content,
                  style: {
                    "body":Style.fromTextStyle(Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize:
                          SizeManager.getResponsiveWidth(14)))
                  },
                  onLinkTap: (url,_,__,___) => url != null ? launchUrl(Uri.parse(url)) : null,
                )
              )
            ],
          ),
        ));
  }
}
