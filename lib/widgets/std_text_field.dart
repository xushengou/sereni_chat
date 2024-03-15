import 'package:flutter/material.dart';

import '../color_const.dart';

class StdTextField extends StatelessWidget {

  late String hintText;
  late IconData textIcon;
  late bool obscure;
  late String returnValue;
  StdTextField({super.key, required this.hintText, required this.textIcon, required this.obscure, required this.returnValue});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        returnValue = value;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: black,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.blue.shade100, //
        filled: true,
        prefixIcon: Icon(textIcon),
      ),
      obscureText: obscure,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}

