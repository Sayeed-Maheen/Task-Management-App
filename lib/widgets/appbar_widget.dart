import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemUiOverlayStyle

class AllScreenAppBarWidget {
  static Widget showCardScreenApp({
    required BuildContext context,
    required String text,
    Widget? leading, // Optional leading widget
    IconData? icon, // Optional icon
    List<Widget>? actions, // Optional actions
    PreferredSizeWidget? bottom, // Optional bottom
    Color backgroundColor =
        Colors.transparent, // Optional background color, default is transparent
    Color textColor = Colors.black, // Optional text color, default is black
    bool isLightStyle = true, // Choose between light or dark style
  }) {
    // Choose the system overlay style based on the isLightStyle flag
    final systemOverlayStyle =
        isLightStyle ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return SliverAppBar(
      pinned: true,
      primary: true,
      backgroundColor:
          backgroundColor, // Use passed color or default to transparent
      leading: leading, // Optional leading widget
      systemOverlayStyle: systemOverlayStyle, // Use chosen system overlay style
      title: responsiveText(
        context: context,
        text: text, // Required text
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: textColor, // Use passed text color or default to black
      ),
      actions: actions, // Optional actions
      bottom: bottom, // Optional bottom widget
    );
  }

  static Widget responsiveText({
    required BuildContext context,
    required String text, // Required text
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
    Color color = Colors.black, // Text color
  }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: fontWeight,
        fontSize: (MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.width / fontSize)),
        fontStyle: fontStyle,
        color: color, // Set the text color here
      ),
    );
  }

  static Widget? responsiveIcon({
    required BuildContext context,
    IconData? icon, // Optional icon
    double size = 24,
    Color color = Colors.black,
  }) {
    if (icon == null) {
      return null; // Return null if no icon is provided
    }
    return Icon(
      icon,
      size: (MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.width / size)),
      color: color,
    );
  }
}
