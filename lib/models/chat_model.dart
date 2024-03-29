import "package:cloud_firestore/cloud_firestore.dart";

class ChatModel{
  final String? cid;
  final List? members;
  final List? messages;

  ChatModel({this.cid, this.members, this.messages});

  factory ChatModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return ChatModel(
      cid: snapshot['cid'],
      members: snapshot['members'],
      messages: snapshot['messages'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "cid": cid,
    "members": members,
    "messages": messages,
  };
}