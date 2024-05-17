import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/databases/database_handler.dart';
import 'package:project/screens/chat_room.dart';
import 'package:project/themes.dart';
import '../widgets/list_box_widget.dart';

class ChatNavScreen extends StatefulWidget {
  const ChatNavScreen({super.key});

  @override
  State<ChatNavScreen> createState() => _ChatNavScreenState();
}

class _ChatNavScreenState extends State<ChatNavScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<List> chats = [];

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

      // Check if the user is not already in the room
      var roomData = openRoomQuery.docs.first.data();
      if (roomData['uid1'] != uid) {
        // Join the open room by setting uid2 to the current user's UID.
        await _firestore.collection("Chat Rooms").doc(roomId).update({
          'uid2': uid,
        });
        final docRef =
            FirebaseFirestore.instance.collection("User Data").doc(uid);

        // Retrieve the current list of chat IDs for the user
        var userData = await docRef.get();
        var cids = List<String>.from(userData.data()?['cids'] ?? []);

        // Append the new roomId to the existing array
        cids.add(roomId);

        // Update the document with the combined list
        docRef.update({"cids": cids});

        return roomId;
      }
    }
    // No open rooms or user is already in the open room, create a new one.
    var newRoomDoc = await _firestore.collection("Chat Rooms").add({
      'uid1': uid,
      'uid2': "",
      'messages': [],
    });
    final docRef = FirebaseFirestore.instance.collection("User Data").doc(uid);

    // Retrieve the current list of chat IDs for the user
    var userData = await docRef.get();
    var cids = List<String>.from(userData.data()?['cids'] ?? []);

    // Append the new roomId to the existing array
    cids.add(newRoomDoc.id);

    // Update the document with the combined list
    docRef.update({"cids": cids});
    return newRoomDoc.id;
  }

// this is for the aibot chatroom
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
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chats",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: IconButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          'Create new Chat',
                          style: Theme.of(context).textTheme.titleLarge,
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
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
                                      cid: cid,
                                      title: 'AI',
                                    ),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child){
                                      var begin = const Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }
                                ),
                              );
                              chats.add(["AI ${chats.length}", cid]);
                            },
                            child: Text(
                              'AiBot',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              // DatabaseHandler.createChat(ChatModel()).then((value) {
                              //   // DatabaseHandler._updateCid(ChatModel().cid);
                              // });
                              var cid = await findOrCreateRoom();
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
                                      cid: cid,
                                      title: 'Person',
                                    ),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child){
                                      var begin = const Offset(0.0, 1.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }
                                ),
                              );
                              chats.add(["Anonymous ${chats.length}", cid]);
                            },
                            child: Text(
                              'Find',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
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

              var myChat = DatabaseHandler.getUid();
              // Extract chats list from Firestore snapshot
              List<List<String>?>? chats = snapshot.data!.docs
                  .map<List<String>?>((doc) {
                    var uid1 = doc['uid1'];
                    var uid2 = doc['uid2'];
                    // to see if you are getting the current user
                    // print(myChat)
                    // print uids to check if you are getting the right values
                    // print(uid1);
                    // print(uid2);
                    // check if they are not null
                    if (uid1 != null && uid2 != null) {
                      if (uid2 != 'AI' && (uid1 == myChat || uid2 == myChat)) {
                        return ['Person', doc.id];
                      } else if (uid2 == 'AI' && uid1 == myChat) {
                        return ['AI', doc.id];
                      }
                    }
                    return null;
                    // get rid of null values so they don't go into chats,
                    // if they go into chats you get red screen.
                  })
                  .where((chat) => chat != null)
                  .toList()
                  .cast<List<String>?>();
              // a lot of ! and ? when using chats indexes
              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(chats[index]![1]),
                    confirmDismiss: (direction) async {
                      final bool res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              "Are you sure you want to delete ${chats[index]?[0]}?",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "Cancel",
                                  style: Theme.of(context).textTheme.titleSmall,
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
                                        .doc(chats[index]?[1])
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
                          PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ChatPage(
                                cid: chats[index]![1],
                                title: chats[index]![0],
                              ),
                              transitionsBuilder: (context, animation, secondaryAnimation, child){
                                var begin = const Offset(0.0, 1.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              }
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0),
                        child: ListBoxWidget(
                          title: '${chats[index]?[1]}',
                          date: "03/19/2024",
                          username: _displayName,
                          marginVal: 5.0,
                          maxLength: 12,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
