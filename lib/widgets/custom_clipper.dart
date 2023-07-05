import 'package:flutter/material.dart';
import 'package:football_universe/res/size_manager.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final bool topLeft;
  // final bool bottomLeft;
  // final bool topRight;
  final bool bottomRight;
  final double diagonal;


  CustomShapeClipper({this.bottomRight = false,this.topLeft = false, this.diagonal = 10.0});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0.0);
    if(!bottomRight)path.lineTo(size.width, size.height);
    if(bottomRight)path.lineTo(size.width-SizeManager.getResponsiveWidth(diagonal), size.height);
    path.lineTo(0.0, size.height);
    if(topLeft)path.lineTo(SizeManager.getResponsiveWidth(diagonal), 0.0);
    if(!topLeft) path.lineTo(0.0, 0.0);
    // path.lineTo(size.width * 0.8, 0.0); 
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}