import 'package:flutter/material.dart';
import 'package:project/screens/chatNavScreen.dart';
import 'package:project/screens/homePage.dart';

import '../color_const.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else if (index == 1) {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChatNavScreen()));
    } else {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary_color,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: secondary_color,
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
                Align(
                  alignment: Alignment.center,
                  child: IconButton.outlined(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                    },
                    icon: const Icon(
                      Icons.person,
                    ),
                    iconSize: 150.0,
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),

                // Account settings
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Account Settings",
                    style: TextStyle(
                      color: mainGrey,
                      fontSize: 10.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: mainGrey),
                  ),
                  width: double.maxFinite,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: whiteGrey,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Account",
                                style: TextStyle(
                                  color: whiteGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: whiteGrey,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: mainGrey,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip_outlined,
                              color: whiteGrey,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Privacy & Safety",
                                style: TextStyle(
                                  color: whiteGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: whiteGrey,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: mainGrey,
                        ),
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
                      color: mainGrey,
                      fontSize: 10.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: mainGrey),
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
                              color: whiteGrey,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Appearance",
                                style: TextStyle(
                                  color: whiteGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: whiteGrey,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: mainGrey,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.accessibility_new,
                              color: whiteGrey,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Accessibility",
                                style: TextStyle(
                                  color: whiteGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: whiteGrey,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: mainGrey,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.translate_outlined,
                              color: whiteGrey,
                              size: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Language",
                                style: TextStyle(
                                  color: whiteGrey,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: whiteGrey,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: mainGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
