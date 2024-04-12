import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';


class DatabaseHandler{
  //create collection
  static Future<void> createUser(UserModel user) async{
    String uid = _getUid();
    final userCollection = FirebaseFirestore.instance.collection("User Data");
    final id = userCollection.doc(uid).id;
    final newUser = UserModel(firstName: "", lastName: "", cids: []).toDocument();

    try{
      userCollection.doc(id).set(newUser);
    } catch(e){
      print(e);
    }
  }

  // create chats
  // static Future<void> createChat(ChatModel chat) async{
  //   String uid = _getUid();
  //   final chatCollection = FirebaseFirestore.instance.collection("Chat data");
  //   final cid = chatCollection.doc().id;
  //   final newChat = ChatModel(cid: cid, members: [uid]).toDocument();
  //
  //   final userCollection = FirebaseFirestore.instance.collection("User data").doc(uid).collection("cids");
  //   await userCollection.doc(cid).set({}); // updates user data's cids list value
  //
  //   try{
  //     chatCollection.doc(cid).set(newChat);
  //   } catch(e){
  //     print(e);
  //   }
  // }

  
  static String _getUid(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    if(uid == null){
      throw Exception("User not authenticated");
    }
    return uid;
  }
}