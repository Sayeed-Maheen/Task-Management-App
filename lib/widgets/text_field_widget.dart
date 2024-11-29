import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class MyFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines; // Add maxLines as a parameter

  const MyFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1, // Default value is 1
  });

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: obscureText,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines, // Use the maxLines parameter
        style: const TextStyle(
          color: colorBlack,
        ),
        decoration: InputDecoration(
          fillColor: colorWhite,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w300,
            fontSize: (MediaQuery.sizeOf(context).width /
                (MediaQuery.sizeOf(context).width / 14)),
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off
                        : Icons.visibility_outlined,
                    color: colorBlack,
                    size: 22,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.all(MediaQuery.sizeOf(context).width /
              (MediaQuery.sizeOf(context).width / 18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorBlackLight,
              width: MediaQuery.sizeOf(context).width /
                  (MediaQuery.sizeOf(context).width / 1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorPrimary,
              width: MediaQuery.sizeOf(context).width /
                  (MediaQuery.sizeOf(context).width / 1),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorRed,
              width: MediaQuery.sizeOf(context).width /
                  (MediaQuery.sizeOf(context).width / 1),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorRed,
              width: MediaQuery.sizeOf(context).width /
                  (MediaQuery.sizeOf(context).width / 1),
            ),
          ),
        ),
      ),
    );
  }
}
