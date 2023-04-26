import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String? fname;
  final String? mname;
  final String? roll;
  final String? number;
  final String? image;

  const UserModel(
      {required this.uid,
      required this.name,
      required this.fname,
      required this.mname,
      required this.roll,
      required this.number,
      required this.image});

  tojson() {
    return {
      "Name": name,
      "Father Name": fname,
      "Mother Name": mname,
      "Roll No": roll,
      "Number": number,
      "Image": image
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      uid: document.id,
      name: data["Name"],
      fname: data["FName"],
      mname: data["MName"],
      roll: data["Roll No"],
      number: data["Number"],
      image: data["Image"],
    );
  }
}
