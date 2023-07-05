import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/widgets/custom_shimmer.dart';

class CustomCachedImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imageUrl;
  final String id;
  const CustomCachedImage({required this.imageUrl,required this.id, this.width, this.height,super.key});

  @override
  Widget build(BuildContext context) {
    return  Hero(
      tag: id,
      child: imageUrl == "" ? Image.asset(Images.imagePlaceHolder, height: height, width: width) : CachedNetworkImage(imageUrl: imageUrl,
                placeholder: (context, url) => const CustomShimmer(),
                errorWidget: (context, url, error) => Image.asset(Images.imagePlaceHolder, height: height, width: width),
                height: height,
                width: width,
                fit: BoxFit.cover,
                ),
    );
  }
}