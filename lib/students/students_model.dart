import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String fname;
  final String mname;
  final String roll;
  final String number;

  const UserModel({
    required this.name,
    required this.fname,
    required this.mname,
    required this.roll,
    required this.number,
  });

  tojson() {
    return {
      "Name": name,
      "Father Name": fname,
      "Mother Name": mname,
      "Roll No": roll,
      "Number": number
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      name: data["Name"],
      fname: data["FName"],
      mname: data["MName"],
      roll: data["Roll No"],
      number: data["Number"],
    );
  }
}
