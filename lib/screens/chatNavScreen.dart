import 'package:flutter/material.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/settingsPage.dart';

import '../color_const.dart';

class ChatNavScreen extends StatefulWidget {
  const ChatNavScreen({super.key});

  @override
  State<ChatNavScreen> createState() => _ChatNavScreenState();
}

class _ChatNavScreenState extends State<ChatNavScreen> {
  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChatNavScreen()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primary_color,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Chats",
                  style: TextStyle(
                    color: secondary_color,
                    fontSize: 30.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Center(
                          child: Text(
                            'Add new chat',
                            style: TextStyle(
                              color: secondary_color,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'AI Bot'),
                            child: const Text('AI Bot'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'Find');
                            },
                            child: const Text('Find'),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    iconSize: 40.0,
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
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
      ),
    );
  }
}
