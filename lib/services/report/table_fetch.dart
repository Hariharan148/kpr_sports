import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>?> fetchAttendanceData(
    DateTimeRange? selectedDataRange) async {
  if (selectedDataRange == null) {
    return null;
  }

  final start = selectedDataRange.start
      .subtract(Duration(days: 1))
      .toIso8601String()
      .toString();
  final end = selectedDataRange.end.toIso8601String().toString();
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final QuerySnapshot<Map<String, dynamic>> snapshot = await attendanceRef
      .where('date', isGreaterThanOrEqualTo: start)
      .where('date', isLessThan: end)
      .get();

  final attendanceDocs = snapshot.docs;
  print(snapshot.docs);
  final studentDataMap = <String, Map<String, bool>>{};
  for (final attendanceDoc in attendanceDocs) {
    final attendanceData = attendanceDoc.data();
    print(attendanceData);
    final studentRef = attendanceDoc.reference.collection('students');
    final studentSnapshot = await studentRef.get();
    final studentDocs = studentSnapshot.docs;
    print(studentDocs);
    for (final studentDoc in studentDocs) {
      final studentData = studentDoc.data();
      print(studentData["name"]);
      if (!studentDataMap.containsKey(studentData["name"])) {
        studentDataMap[studentData["name"]] = <String, bool>{};
      }
      studentDataMap[studentData["name"]]![attendanceData['date']] =
          studentData['attendanceStatus'];
    }
  }

  final sortedDates = studentDataMap.entries.fold(<String>{}, (dates, entry) {
    dates.addAll(entry.value.keys);
    return dates;
  }).toList()
    ..sort();

  return {'studentDataMap': studentDataMap, 'dates': sortedDates};
}
