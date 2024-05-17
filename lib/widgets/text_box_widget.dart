import 'package:flutter/material.dart';

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
      cursorColor: Colors.black,
      maxLines: maxLines,
      controller: controller,
      minLines: 1,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        // Hint text:
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall,

        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        // Border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              width: 0.0,
              style: BorderStyle.none,
              // color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
