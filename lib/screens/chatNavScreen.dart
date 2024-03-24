import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/settingsPage.dart';

import '../color_const.dart';
import '../widgets/list_box_widget.dart';

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

  var chats = [];

  // current date in mm/dd/yyyy
  // String currentDate = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

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
                        title: const Text(
                          'Create new Chat',
                          style: TextStyle(
                            color: secondary_color,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: (){
                              chats.add("${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())} AI");
                              Navigator.pop(context, 'AiBot');
                            },
                            child: const Text('AiBot'),
                          ),
                          TextButton(
                            onPressed: () {
                              chats.add("${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())} Person");
                              Navigator.pop(context, 'Find');
                            },
                            child: const Text('Find'),
                          ),
                        ],
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
        body: Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ListBoxWidget(title: '${index + 1}. ${chats[index]}', date: "03/19/2024", username: "username", marginVal: 5.0);
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
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