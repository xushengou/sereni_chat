import "package:cloud_firestore/cloud_firestore.dart";

class UserModel{
  final String? id;
  final String? username;

  UserModel({this.id, this.username});

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
      id: snapshot['id'],
      username: snapshot['username'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "id": id,
    "username": username,
  };
}