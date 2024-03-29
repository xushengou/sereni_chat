import "package:cloud_firestore/cloud_firestore.dart";

class UserModel{
  final String? firstName;
  final String? lastName;
  final List? cids;

  UserModel({this.firstName, this.lastName, this.cids});

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
      firstName: snapshot['first_name'],
      lastName: snapshot['last_name'],
      cids: snapshot['cids'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "first_name": firstName,
    "last_name": lastName,
    "cids": cids,
  };
}