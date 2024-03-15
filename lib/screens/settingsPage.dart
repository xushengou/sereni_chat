import 'package:flutter/material.dart';
import 'package:project/screens/chatNavScreen.dart';
import 'package:project/screens/chatPage.dart';
import 'package:project/screens/homePage.dart';

import '../color_const.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  void onTabTapped(int index) {
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    else if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatNavScreen()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
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
