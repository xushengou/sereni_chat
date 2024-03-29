import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';


class DatabaseHandler{
  //create collection
  static Future<void> createUser(UserModel user) async{
    String uid = _getUid();
    final userCollection = FirebaseFirestore.instance.collection("User data");
    final id = userCollection.doc(uid).id;
    final newUser = UserModel(firstName: "", lastName: "").toDocument();

    try{
      userCollection.doc(id).set(newUser);
    } catch(e){
      print(e);
    }
  }

  // get Chats

  
  static String _getUid(){
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    if(uid == null){
      throw Exception("User not authenticated");
    }
    return uid;
  }
}