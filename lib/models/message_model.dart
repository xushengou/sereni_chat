import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String user;
  final DateTime timestamp;

  const MessageModel({required this.message, required this.user, required this.timestamp});
  // const MessageModel({required this.isMe, required this.timestamp});


  factory MessageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return MessageModel(
      message: snapshot['message'],
      user: snapshot['user'],
      timestamp: snapshot['timestamp'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "message": message,
    "user": user,
    "timestamp": timestamp,
  };
}