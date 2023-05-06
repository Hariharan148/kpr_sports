import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? pemail;
  final String? phone;
  final String? pphone;
  final String? image;
  final String? roll;
  final String? sec;
  final String? sport;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.pemail,
    required this.phone,
    required this.pphone,
    required this.image,
    required this.roll,
    required this.sec,
    required this.sport,
  });

  // tojson() {
  //   return {
  //     "Name": name,
  //     "Father Name": fname,
  //     "Mother Name": mname,
  //     "Roll No": roll,
  //     "Number": number,
  //     "Image": image
  //   };
  // }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      uid: document.id,
      name: data["name"],
      email: data["email"],
      pemail: data["parentEmail"],
      phone: data["phone"],
      pphone: data["parentPhone"],
      sec: data["section"],
      roll: data["rollno"],
      sport: data["sport"],
      image: data["image"]
    );
  }
}
