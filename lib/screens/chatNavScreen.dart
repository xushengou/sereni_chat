import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/models/chat_model.dart';
import 'package:project/screens/chatPage.dart';
import 'package:project/screens/homePage.dart';
import 'package:project/screens/settingsPage.dart';

import '../color_const.dart';
import '../databases/database_handler.dart';
import '../widgets/list_box_widget.dart';

class ChatNavScreen extends StatefulWidget {
  const ChatNavScreen({super.key});

  @override
  State<ChatNavScreen> createState() => _ChatNavScreenState();
}

class _ChatNavScreenState extends State<ChatNavScreen> {

  var chats = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<String> findOrCreateRoom() async {
    final openRoomQuery = await _firestore.collection("Chat Rooms").where('uid2', isEqualTo: "").limit(1).get();
    var uid = FirebaseAuth.instance.currentUser?.uid;

    if(openRoomQuery.docs.isNotEmpty){
      // An open room exists
      var roomId = openRoomQuery.docs.first.id;
      // Join the open room by setting uid2 to the current user's UID.
      await _firestore.collection("Chat Rooms").doc(roomId).update({
        'uid2': uid,
      });
      final docRef = FirebaseFirestore.instance.collection("User Data").doc(uid);
      docRef.update({"cids": [roomId]});
      return roomId;
    } else {
      // No open rooms, create a new one.
      var newRoomDoc = await _firestore.collection("Chat Rooms").add({
        'uid1': uid,
        'uid2': "",
        'messages': [],
      });
      final docRef = FirebaseFirestore.instance.collection("User Data").doc(uid);
      docRef.update({"cids": [newRoomDoc.id]});
      return newRoomDoc.id;
    }
  }

  String _displayName = '';
  @override
  void initState() {
    super.initState();
    // Retrieve current user's display name when the widget is initialized
    getUserDisplayName();
  }

  Future<void> getUserDisplayName() async {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Retrieve user's display name
    if (user != null) {
      setState(() {
        _displayName = user.displayName ?? 'No name';
      });
    }
  }

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
                              // DatabaseHandler.createChat(ChatModel()).then((value) {
                              //   // DatabaseHandler._updateCid(ChatModel().cid);
                              // });
                              var cid = findOrCreateRoom();
                              Navigator.pop(context);  // remove the pop up screen
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ChatPage()));
                              chats.add("AI: ${chats.length}");
                            },
                            child: const Text('AiBot'),
                          ),
                          TextButton(
                            onPressed: () {
                              chats.add("Person: ${chats.length}");
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
              return ListBoxWidget(title: '${index + 1}. ${chats[index]}', date: "03/19/2024", username: _displayName, marginVal: 5.0);
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