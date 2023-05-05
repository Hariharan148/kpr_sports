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
      name: data["Name"],
      email: data["Email"],
      pemail: data["PEmail"],
      phone: data["Phone"],
      pphone: data["PPhone"],
      sec: data["Section"],
      roll: data["Roll No"],
      sport: data["Sport"],
      image: data["Image"]
    );
  }
}

class Faculty {

  final String? name;


  const Faculty({

    required this.name,

  });



  factory Faculty.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Faculty(

      name: data["Name"],

    );
  }
}
