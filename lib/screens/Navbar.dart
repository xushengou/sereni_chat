import 'package:flutter/material.dart';
import 'package:project/screens/settings.dart';

import 'chat_navigation.dart';
import 'home.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            // icon: Badge(child: Icon(Icons.notifications_sharp)),
            icon: Icon(Icons.notifications_sharp),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        // Home
        const HomePage(),
        // Chat
        const ChatNavScreen(),
        // Settings
        const SettingsPage(),
      ][currentPageIndex],
    );
  }
}
