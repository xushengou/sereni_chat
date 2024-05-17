import 'package:flutter/material.dart';
import '../../color_const.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkTheme1,
        title: const Text(
          "Appearance",
          style: TextStyle(
            color: white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
