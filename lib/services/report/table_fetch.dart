import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<Map<String, dynamic>?> fetchAttendanceData(
    DateTimeRange? selectedDataRange) async {
  if (selectedDataRange == null) {
    return null;
  }

  final start = selectedDataRange.start
      .subtract(const Duration(days: 1))
      .toIso8601String();
  final end = selectedDataRange.end.toIso8601String();
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final QuerySnapshot<Map<String, dynamic>> snapshot = await attendanceRef
      .where('date', isGreaterThanOrEqualTo: start, isLessThan: end)
      .get();

  final studentDataMap = <String, Map<String, bool>>{};
  final sortedDates = <String>{};

  for (final attendanceDoc in snapshot.docs) {
    final attendanceData = attendanceDoc.data();
    final studentRef = attendanceDoc.reference.collection('students');
    final studentSnapshot = await studentRef.get();
    final studentDocs = studentSnapshot.docs;
    for (final studentDoc in studentDocs) {
      final studentData = studentDoc.data();
      final name = studentData['name'];
      final attendanceStatus = studentData['attendanceStatus'];

      if (!studentDataMap.containsKey(name)) {
        studentDataMap[name] = <String, bool>{};
      }

      studentDataMap[name]![attendanceData['date']] = attendanceStatus;
      sortedDates.add(attendanceData['date']);
    }
  }

  sortedDates.toList()..sort();

  return {'studentDataMap': studentDataMap, 'dates': sortedDates};
}
