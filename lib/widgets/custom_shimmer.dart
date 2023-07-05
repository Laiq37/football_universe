import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  const CustomShimmer({this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[50]!,
      child: Container(
        color: Colors.grey[500],
        width: width,
        height: height,
      ),
    );
  }
}
