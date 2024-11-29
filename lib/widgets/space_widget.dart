import 'package:flutter/material.dart';

class SpaceWidget {
  static Widget spaceWidget({
    required BuildContext context,
    double spaceHeight = 0.0,
    double spaceWidth = 0.0,
  }) {
    if (spaceHeight != 0.0 && spaceWidth != 0.0) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height /
            (MediaQuery.sizeOf(context).height / spaceHeight),
        width: MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / spaceWidth),
      );
    } else if (spaceHeight != 0.0 && spaceWidth == 0.0) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height /
            (MediaQuery.sizeOf(context).height / spaceHeight),
      );
    } else if (spaceHeight == 0.0 && spaceWidth != 0.0) {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / spaceWidth),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
