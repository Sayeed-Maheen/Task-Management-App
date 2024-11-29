import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label; // Required label
  final String? icon; // Optional icon
  final double? iconHeight;
  final double? iconWidth;
  final Color buttonColor; // Button background color
  final Color textColor; // Label text color
  final double fontSize; // Label text size
  final VoidCallback? onPressed; // Callback for button press
  final double buttonHeight; // Height of the button
  final double buttonWidth; // Width of the button
  final EdgeInsetsGeometry? padding; // Padding inside the button
  final BorderRadiusGeometry buttonRadius;

  const CustomButtonWidget({
    super.key,
    required this.label,
    this.icon,
    this.iconHeight,
    this.iconWidth,
    this.buttonColor = Colors.blue, // Default color is blue
    this.textColor = Colors.white, // Default text color is white
    this.fontSize = 16.0, // Default text size is 16.0
    this.onPressed,
    this.buttonHeight = 50.0, // Default height
    this.buttonWidth = 200.0, // Default width
    this.padding, // Default padding
    this.buttonRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.sizeOf(context).height /
          (MediaQuery.sizeOf(context).height / buttonHeight)),
      width: (MediaQuery.sizeOf(context).width /
          (MediaQuery.sizeOf(context).width / buttonWidth)),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Background color
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / 16)),
          shape: RoundedRectangleBorder(
            borderRadius: buttonRadius, // Rounded corners
          ),
        ),
        icon: icon != null
            ? SvgPicture.asset(
                icon!,
                color: textColor,
                height: MediaQuery.sizeOf(context).width /
                    (MediaQuery.sizeOf(context).width / iconHeight!),
                width: MediaQuery.sizeOf(context).width /
                    (MediaQuery.sizeOf(context).width / iconWidth!),
              )
            : null, // Optional icon
        label: Text(
          label,
          style: TextStyle(
            color: textColor, // Text color
            fontSize: (MediaQuery.sizeOf(context).width /
                (MediaQuery.sizeOf(context).width / fontSize)),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
