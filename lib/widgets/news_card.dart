import 'package:flutter/material.dart';
import 'package:football_universe/models/news.dart';
import 'package:football_universe/res/size_manager.dart';
import 'package:football_universe/widgets/custom_cached_image.dart';
class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.getResponsiveWidth(285),
      width: SizeManager.deviceWidth,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            left: SizeManager.getResponsiveWidth(SizeManager.big),
            right: SizeManager.getResponsiveWidth(SizeManager.big),
            top: SizeManager.getResponsiveWidth(SizeManager.big),
            bottom: SizeManager.getResponsiveWidth(SizeManager.small),
          ),
          child: Column(
            children: [
              CustomCachedImage(
                id:news.id,
                imageUrl: news.image,
                width: SizeManager.getResponsiveWidth(320),
                height: SizeManager.getResponsiveWidth(187),
              ),
              SizedBox(
                height: SizeManager.getResponsiveWidth(SizeManager.small),
              ),
              Expanded(
                child: Text(
                  // "Victory over the third division club in thesecond friendly match of the preseason",
                  news.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textScaleFactor: SizeManager.getTextScaleFactor(context),
                  // overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: SizeManager.getResponsiveWidth(SizeManager.smaller),
              ),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    '${news.postTime.year}.${news.postTime.month.toString().padLeft(2, '0')}.${news.postTime.day.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.labelSmall,
                    textScaleFactor: SizeManager.getTextScaleFactor(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
