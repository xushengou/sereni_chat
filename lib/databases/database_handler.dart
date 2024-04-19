import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class DatabaseHandler {
  //create collection
  static Future<void> createUser(UserModel user) async {
    String uid = _getUid();
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
    final messageCollection = FirebaseFirestore.instance.collection(cid);
    return messageCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => MessageModel.fromSnapshot(e)).toList());
  }

  static String _getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    if (uid == null) {
      throw Exception("User not authenticated");
    }
    return uid;
  }
}
