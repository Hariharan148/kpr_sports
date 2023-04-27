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

  if (start == end) {
  } else {}

  print(start);
  print(end);

// Get a list of all dates with attendance data
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');
  final QuerySnapshot<Map<String, dynamic>> snapshot = await attendanceRef
      .where('date', isGreaterThan: start, isLessThan: end)
      .orderBy('date')
      .get();

  final dateList =
      snapshot.docs.map((doc) => doc.data()['date'].substring(0, 10)).toList();
  print("date list${dateList}");

// Loop through the selected date range and ensure that we have data for each date
  final studentDataMap = <String, Map<String, bool>>{};
  final sortedDates = <String>{};
  for (var i = 0; i < selectedDataRange.duration.inDays; i++) {
    final date = DateTime.parse(start)
        .add(const Duration(days: 1))
        .toIso8601String()
        .substring(0, 10);
    if (!dateList.contains(date)) {
      // If we don't have data for this date, add an empty value to the list of attendance data
      dateList.add(date);
      sortedDates.add(date);
    }
    start =
        DateTime.parse(start).add(const Duration(days: 1)).toIso8601String();
  }

  print("sort${sortedDates}");

// Loop through the attendance data and add it to the studentDataMap
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

      if (attendanceStatus != null) {
        studentDataMap[name]![attendanceData['date']] = attendanceStatus;
      }

      sortedDates.add(attendanceData['date'].substring(0, 10));
    }
  }

  final sortedDateList = sortedDates.toList()..sort();

// Loop through the studentDataMap and create the list of attendance data
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

  print("map${studentDataMap}");
  print("date${dateList}");
  print("order${sortedDateList}");

  reportProvider.setStudentData = dataList;
  reportProvider.setDates = sortedDateList;

  return dataList;
}
