import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

CollectionReference students =
    FirebaseFirestore.instance.collection("students");

void getAttendanceStatus(Function(List<Map<String, dynamic>>)? onSuccess,
    Function(dynamic)? onError, AttendanceProvider attendanceProvider) {
  students.orderBy("name").get().then((QuerySnapshot querySnapshot) async {
    final attendenceStatus = querySnapshot.docs
        .map((doc) => {
              "uid": doc.id,
              "name": doc["name"],
              "rollno": doc["rollno"],
              "status": false,
            })
        .toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? serializedList = prefs.getString('attendanceState');
    List<dynamic> myList =
        serializedList != null ? json.decode(serializedList) : [];

    attendanceProvider.presentVal = 0;

    if (myList.isNotEmpty) {
      for (var element in attendenceStatus) {
        for (var item in myList) {
          if (element["uid"] == item["uid"]) {
            element["status"] = item["status"];
            if (element["status"] == true) {
              attendanceProvider.presentVal = attendanceProvider.present + 1;
            }
          }
        }
      }
    } else {
      String serializedList = json.encode(attendenceStatus);
      await prefs.setString('attendanceState', serializedList);
    }
    onSuccess?.call(attendenceStatus);
  }).catchError((error) {
    onError?.call(error);
  });
}
