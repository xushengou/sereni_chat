import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final bool isMe;
  final DateTime timestamp;

  const MessageModel({required this.message, required this.isMe, required this.timestamp});

  factory MessageModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return MessageModel(
      message: snapshot['message'],
      isMe: snapshot['isMe'],
      timestamp: snapshot['timestamp'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "message": message,
    "isMe": isMe,
    "timestamp": timestamp,
  };
}