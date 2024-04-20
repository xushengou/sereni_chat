import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class DatabaseHandler {
  //create collection
  static Future<void> createUser(UserModel user) async {
    String uid = getUid();
    final userCollection = FirebaseFirestore.instance.collection("User Data");
    final id = userCollection.doc(uid).id;
    final newUser =
        UserModel(firstName: "", lastName: "", cids: []).toDocument();

    try {
      userCollection.doc(id).set(newUser);
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<MessageModel>> getMessages(String cid) {
    final messageDocument = FirebaseFirestore.instance
        .collection('Chat Rooms')
        .doc(cid);

    return messageDocument.snapshots().map((documentSnapshot) {
      if (!documentSnapshot.exists || documentSnapshot.data() == null) {
        return []; // Return an empty list if document doesn't exist or data is null
      }

      // Extract the messages list from the document data
      List<dynamic> messagesData = documentSnapshot.data()!['messages'];
      if (messagesData == null || messagesData.isEmpty) {
        return []; // Return an empty list if messages data is null or empty
      }

      // Convert messages data to MessageModel objects
      return messagesData.map((message) {
        return MessageModel(
          message: message['message'] ?? '',
          user: message['user'] ?? "",
          timestamp: (message['timestamp'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  static String getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    if (uid == null) {
      throw Exception("User not authenticated");
    }
    return uid;
  }
}
