import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/store/attendance_provider.dart';

class AttendanceService {
  static Future<void> submitAttendance(
      AttendanceProvider attendanceProvider) async {
    final attendanceStatus = attendanceProvider.attendanceStatus;
    final today = DateTime.now().toString().substring(0, 10);
    final attendanceRef =
        FirebaseFirestore.instance.collection("attendance").doc(today);

    try {
      print("came");
      await Future.wait([
        attendanceRef.set({
          "date": today,
        }),
        ...attendanceStatus.map((status) =>
            attendanceRef.collection("students").doc(status["uid"]).set({
              "name": status["name"],
              "rollno": status["rollno"],
              "attendanceStatus": status["status"],
            })),
      ]);
    } catch (error) {
      print("p");
      rethrow;
    }
  }
}
