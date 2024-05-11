import 'package:flutter/material.dart';
import 'package:project/color_const.dart';

class ChatTXTWidget extends StatelessWidget {
  final int? maxLines;
  final double? fontSize;
  final TextEditingController controller;
  final String hintText;

  const ChatTXTWidget({
    super.key,
    required this.controller,
    this.fontSize,
    required this.hintText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      minLines: 1,
      style: const TextStyle(
        // fontSize: fontSize,
        color: lightShadedWhite,
        fontFamily: "Poppins",
      ),
      decoration: InputDecoration(
        // Hint text:
        hintText: hintText,
        hintStyle: const TextStyle(
          color: darkShadedWhite,
        ),

        filled: true,
        fillColor: darkTheme1,
        // Border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }
}
