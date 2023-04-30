import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:provider/provider.dart';

Future<List<List<dynamic>>?> fetchAttendanceData(
    BuildContext context, DateTimeRange? selectedDataRange) async {
  final reportProvider = Provider.of<ReportProvider>(context, listen: false);

  if (selectedDataRange == null) {
    return null;
  }

  var start = selectedDataRange.start
      .subtract((const Duration(days: 1)))
      .toIso8601String()
      .substring(0, 10);
  final end = selectedDataRange.end
      .add((const Duration(days: 1)))
      .toIso8601String()
      .substring(0, 10);

  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final QuerySnapshot<Map<String, dynamic>> snapshot = await attendanceRef
      .where('date', isGreaterThan: start, isLessThan: end)
      .orderBy('date')
      .get();

  final dateList =
      snapshot.docs.map((doc) => doc.data()['date'].substring(0, 10)).toList();

  final studentDataMap = <String, Map<String, bool>>{};
  final sortedDates = <String>{};
  for (var i = 0; i < selectedDataRange.duration.inDays; i++) {
    final date = DateTime.parse(start)
        .add(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 10);
    if (!dateList.contains(date)) {
      dateList.add(date);
      sortedDates.add(date);
    }
    start =
        DateTime.parse(start).add(const Duration(days: 1)).toIso8601String();
  }

  for (final attendanceDoc in snapshot.docs) {
    final attendanceData = attendanceDoc.data();
    final studentRef =
        attendanceDoc.reference.collection('students').orderBy("name");
    final studentSnapshot = await studentRef.get();
    final studentDocs = studentSnapshot.docs;
    for (final studentDoc in studentDocs) {
      final studentData = studentDoc.data();
      final name = studentData['name'];
      final attendanceStatus = studentData['attendanceStatus'];

      if (!studentDataMap.containsKey(name)) {
        studentDataMap[name] = <String, bool>{};
      }

      if (attendanceStatus != null) {
        studentDataMap[name]![attendanceData['date']] = attendanceStatus;
      }

      sortedDates.add(attendanceData['date'].substring(0, 10));
    }
  }

  final sortedDateList = sortedDates.toList()..sort();

  final dataList = <List<dynamic>>[];
  studentDataMap.forEach((key, value) {
    final row = <dynamic>[key];
    for (var date in sortedDateList) {
      row.add(value[date] == null
          ? null
          : value[date] == true
              ? "Present"
              : "Absent");
    }
    dataList.add(row);
  });

  reportProvider.setStudentData = dataList;
  reportProvider.setDates = sortedDateList;

  return dataList;
}
