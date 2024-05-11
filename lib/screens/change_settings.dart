import 'package:flutter/material.dart';

import '../color_const.dart';

class changeSettingsPage extends StatefulWidget {
  final String setting;
  const changeSettingsPage({super.key, required this.setting});

  @override
  State<changeSettingsPage> createState() => _changeSettingsPageState();
}

class _changeSettingsPageState extends State<changeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.setting,
          style: const TextStyle(
            color: white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
