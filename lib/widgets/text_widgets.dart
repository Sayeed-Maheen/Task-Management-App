import 'package:flutter/material.dart';

class CustomTextWidget {
  static Widget plainTextContainerWidget({
    required BuildContext context,
    double plainTextContainerHeight = 50,
    double plainTextContainerWidth = 50.0,
    Color plainTextContainerColor = Colors.transparent,
    Alignment plainTextContainerAlignment = Alignment.center,
    required String plainTextString,
    FontWeight plainTextStringFontWeight = FontWeight.w400,
    double plainTextStringFontSize = 14,
    FontStyle plainTextStringFontStyle = FontStyle.normal,
    Color plainTextStringFontColor = Colors.transparent,
    TextOverflow? overflow,
    int? maxLines,
    TextAlign plainTextAlignment = TextAlign.center,
  }) {
    return Container(
      height: (MediaQuery.sizeOf(context).height /
          (MediaQuery.sizeOf(context).height / plainTextContainerHeight)),
      width: (MediaQuery.sizeOf(context).width /
          (MediaQuery.sizeOf(context).width / plainTextContainerWidth)),
      decoration: BoxDecoration(
        color: plainTextContainerColor,
      ),
      alignment: plainTextContainerAlignment,
      child: Text(
        plainTextString,
        overflow: overflow,
        maxLines: maxLines,
        textAlign: plainTextAlignment,
        style: TextStyle(
          fontWeight: plainTextStringFontWeight,
          fontSize: (MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / plainTextStringFontSize)),
          fontStyle: plainTextStringFontStyle,
          color: plainTextStringFontColor,
        ),
      ),
    );
  }

  static Widget plainTextWidget({
    required BuildContext context,
    required String plainTextString,
    FontWeight plainTextStringFontWeight = FontWeight.w400,
    double plainTextStringFontSize = 14,
    FontStyle plainTextStringFontStyle = FontStyle.normal,
    Color plainTextStringFontColor = Colors.transparent,
    TextOverflow? overflow,
    int? maxLines,
    TextAlign plainTextAlignment = TextAlign.center,
  }) {
    return Text(
      plainTextString,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: plainTextAlignment,
      style: TextStyle(
          fontWeight: plainTextStringFontWeight,
          fontSize: (MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / plainTextStringFontSize)),
          fontStyle: plainTextStringFontStyle,
          color: plainTextStringFontColor),
    );
  }

  static Widget richTextContainerWidget({
    required BuildContext context,
    double richTextContainerHeight = 50.0,
    double richTextContainerWidth = 378.0,
    Alignment richTextContainerAlignment = Alignment.center,
    required String primaryText,
    required double richTextFontSize,
    FontWeight richTextFontWeight = FontWeight.normal,
    FontStyle richTextFontStyle = FontStyle.normal,
    Color richTextFontColor = Colors.white,
    required List<TextSpan> textSpanList,
  }) {
    return Container(
      height: (MediaQuery.sizeOf(context).height /
          (MediaQuery.sizeOf(context).height / richTextContainerHeight)),
      width: (MediaQuery.sizeOf(context).width /
          (MediaQuery.sizeOf(context).width / richTextContainerWidth)),
      decoration: const BoxDecoration(color: Colors.transparent),
      alignment: richTextContainerAlignment,
      child: RichText(
        text: TextSpan(
          text: primaryText,
          style: richTextStyle(
              context: context,
              fontSize: richTextFontSize,
              fontStyle: richTextFontStyle,
              fontWeight: richTextFontWeight,
              fontColor: richTextFontColor),
          children: textSpanList,
        ),
      ),
    );
  }

  static TextStyle richTextStyle({
    required BuildContext context,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    Color fontColor = Colors.white,
  }) {
    return TextStyle(
        fontSize: (MediaQuery.sizeOf(context).width /
            (MediaQuery.sizeOf(context).width / fontSize)),
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: fontColor);
  }
}
