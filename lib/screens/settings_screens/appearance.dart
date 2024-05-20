import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Appearance",
          style: TextStyle(
            color: Colors.black,
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