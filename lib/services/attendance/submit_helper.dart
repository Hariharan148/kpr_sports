import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/store/attendance_provider.dart';

class AttendanceService {
  static Future<void> submitAttendance(
      AttendanceProvider attendanceProvider) async {
    final attendanceStatus = attendanceProvider.attendanceStatus;
    final today = DateTime.now().toString().substring(0, 10);
    final attendanceRef = FirebaseFirestore.instance
        .collection("attendance")
        .doc(today)
        .collection("students");

    try {
      await Future.wait(attendanceStatus
          .map((status) => attendanceRef.doc(status["uid"]).set({
                "name": status["name"],
                "rollno": status["rollno"],
                "attendanceStatus": status["status"],
              })));
      print("success");
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
