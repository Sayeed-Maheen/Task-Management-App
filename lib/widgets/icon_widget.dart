import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String iconPath;
  final double? iconHeight;
  final double? iconWidth;
  final Color? color; // Added color parameter

  const CustomIcon({
    super.key,
    required this.iconPath,
    this.iconHeight,
    this.iconWidth,
    this.color, // Initialize the color parameter
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: MediaQuery.sizeOf(context).width /
          (MediaQuery.sizeOf(context).width / iconHeight!),
      width: MediaQuery.sizeOf(context).width /
          (MediaQuery.sizeOf(context).width / iconWidth!),
      color: color, // Pass the color parameter to the SVG asset
    );
  }
}
