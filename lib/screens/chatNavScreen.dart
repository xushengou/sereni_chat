import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/chatPage.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<List> chats = [];
  // var chats = [];

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

  Future<String> findOrCreateRoom() async {
    final openRoomQuery = await _firestore
        .collection("Chat Rooms")
        .where('uid2', isEqualTo: "")
        .limit(1)
        .get();
    var uid = FirebaseAuth.instance.currentUser?.uid;

    if (openRoomQuery.docs.isNotEmpty) {
      // An open room exists
      var roomId = openRoomQuery.docs.first.id;
      // Join the open room by setting uid2 to the current user's UID.
      await _firestore.collection("Chat Rooms").doc(roomId).update({
        'uid2': uid,
      });
      final docRef =
          FirebaseFirestore.instance.collection("User Data").doc(uid);
      docRef.update({
        "cids": [roomId]
      });
      return roomId;
    } else {
      // No open rooms, create a new one.
      var newRoomDoc = await _firestore.collection("Chat Rooms").add({
        'uid1': uid,
        'uid2': "",
        'messages': [],
      });
      final docRef =
          FirebaseFirestore.instance.collection("User Data").doc(uid);
      docRef.update({
        "cids": FieldValue.arrayUnion([newRoomDoc.id])
      });
      return newRoomDoc.id;
    }
  }

  Future<String> createRoom() async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var newRoomDoc = await _firestore.collection("Chat Rooms").add({
      'uid1': uid,
      'uid2': "AI",
      'messages': [],
    });
    final docRef = FirebaseFirestore.instance.collection("User Data").doc(uid);
    docRef.update({
      "cids": FieldValue.arrayUnion([newRoomDoc.id])
    });
    return newRoomDoc.id;
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
        _displayName = user.displayName ?? '';
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
                            onPressed: () async {
                              // DatabaseHandler.createChat(ChatModel()).then((value) {
                              //   // DatabaseHandler._updateCid(ChatModel().cid);
                              // });
                              var cid = await createRoom();
                              if (!context.mounted) return;
                              Navigator.pop(
                                  context); // remove the pop up screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            cid: cid,
                                          )));
                              chats.add(["AI ${chats.length}", cid]);
                            },
                            child: const Text('AiBot'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // DatabaseHandler.createChat(ChatModel()).then((value) {
                              //   // DatabaseHandler._updateCid(ChatModel().cid);
                              // });
                              var cid = await findOrCreateRoom();
                              if (!context.mounted) return;
                              Navigator.pop(
                                  context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            cid: cid,
                                          )));
                              chats.add(["Anonymous ${chats.length}", cid]);
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
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _firestore.collection("Chat Rooms").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // Extract chats list from Firestore snapshot
              chats = snapshot.data!.docs.map((doc) {
                if (doc['uid2'] != 'AI') {
                  return ['Person', doc.id];
                }
                return ['AI', doc.id];
              }).toList();

              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(chats[index][1]),
                    confirmDismiss: (direction) async {
                      final bool res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              "Are you sure you want to delete ${chats[index][0]}?",
                              style: const TextStyle(color: Colors.white),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // Return false when canceled
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Delete the chat document from Firestore
                                    _firestore
                                        .collection("Chat Rooms")
                                        .doc(chats[index][1])
                                        .delete();
                                  });
                                  Navigator.of(context)
                                      .pop(true); // Return true when deleted
                                },
                              ),
                            ],
                          );
                        },
                      );
                      return res;
                    },
                    background: Container(
                      color: Colors.red, // Background color when swiping
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatPage(cid: chats[index][1]),
                          ),
                        );
                      },
                      child: ListBoxWidget(
                        title: '${index + 1}. ${chats[index][1]}',
                        date: "03/19/2024",
                        username: _displayName,
                        marginVal: 5.0,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // child: ListView.separated(
          //   padding: const EdgeInsets.all(8),
          //   itemCount: chats.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     // return GestureDetector(
          //     //   onTap: () {
          //     //     Navigator.push(context,
          //     //         MaterialPageRoute(builder: (context) => ChatPage(cid: chats[index][1])));
          //     //   },
          //     //   child: ListBoxWidget(
          //     //       title: '${index + 1}. ${chats[index][0]}',
          //     //       date: "03/19/2024",
          //     //       username: _displayName,
          //     //       marginVal: 5.0),
          //     // );
          //     return Dismissible(
          //       key: Key(chats[index][1]),
          //       confirmDismiss: (direction) async {
          //         final bool res = await showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               content: Text(
          //                 "Are you sure you want to delete ${chats[index][0]}?",
          //                 style: const TextStyle(color: Colors.white),
          //               ),
          //               actions: <Widget>[
          //                 TextButton(
          //                   child: const Text(
          //                     "Cancel",
          //                     style: TextStyle(color: Colors.white),
          //                   ),
          //                   onPressed: () {
          //                     Navigator.of(context).pop(false); // Return false when canceled
          //                   },
          //                 ),
          //                 TextButton(
          //                   child: const Text(
          //                     "Delete",
          //                     style: TextStyle(color: Colors.red),
          //                   ),
          //                   onPressed: () {
          //                     setState(() {
          //                       chats.removeAt(index);
          //                     });
          //                     Navigator.of(context).pop(true); // Return true when deleted
          //                   },
          //                 ),
          //               ],
          //             );
          //           },
          //         );
          //         return res;
          //       },
          //       background: Container(
          //         color: Colors.red, // Background color when swiping
          //         alignment: Alignment.centerRight,
          //         child: const Padding(
          //           padding: EdgeInsets.only(right: 20.0),
          //           child: Icon(
          //             Icons.delete,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => ChatPage(cid: chats[index][1]),
          //             ),
          //           );
          //         },
          //         child: ListBoxWidget(
          //           title: '${index + 1}. ${chats[index][0]}',
          //           date: "03/19/2024",
          //           username: _displayName,
          //           marginVal: 5.0,
          //         ),
          //       ),
          //     );
          //   },
          //   separatorBuilder: (BuildContext context, int index) =>
          //   const Divider(),
          // ),
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
