import "package:cloud_firestore/cloud_firestore.dart";

class ChatModel{
  final String? cid;
  final List? members;

  ChatModel({this.cid, this.members});

  factory ChatModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return ChatModel(
      cid: snapshot['cid'],
      members: snapshot['members'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "cid": cid,
    "members": members,
  };
}