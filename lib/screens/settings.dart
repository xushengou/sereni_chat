import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../color_const.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkTheme1,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: white,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              // Account settings
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account Settings",
                  style: TextStyle(
                    color: lightShadedWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: lightShadedWhite),
                ),
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(context, )
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: lightShadedWhite,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Account",
                                style: TextStyle(
                                  color: lightShadedWhite,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: lightShadedWhite,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: lightShadedWhite,
                      ),
                      GestureDetector(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: lightShadedWhite,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Privacy & Safety",
                                style: TextStyle(
                                  color: lightShadedWhite,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: lightShadedWhite,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(
                      //   color: lightShadedWhite,
                      // ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              // App Settings
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "App Settings",
                  style: TextStyle(
                    color: lightShadedWhite,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: lightShadedWhite),
                ),
                width: double.maxFinite,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.palette,
                            color: lightShadedWhite,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Appearance",
                              style: TextStyle(
                                color: lightShadedWhite,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: lightShadedWhite,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: lightShadedWhite,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.accessibility_new,
                            color: lightShadedWhite,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Accessibility",
                              style: TextStyle(
                                color: lightShadedWhite,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: lightShadedWhite,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: lightShadedWhite,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.translate_outlined,
                            color: lightShadedWhite,
                            size: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Language",
                              style: TextStyle(
                                color: lightShadedWhite,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: lightShadedWhite,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
