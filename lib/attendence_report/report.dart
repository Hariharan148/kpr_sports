import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/attendence_report/date_time.dart';
import 'package:kpr_sports/students/students.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? _selectedDataRange;

  void _handleDateRangeSelected(DateTimeRange dateRange) {
    setState(() {
      _selectedDataRange = dateRange;
    });
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    final attendanceRef = FirebaseFirestore.instance.collection("attendance");
    print("hi");
    print(_selectedDataRange?.start.toString());
    print(_selectedDataRange?.end.toIso8601String().toString());
    final start = _selectedDataRange?.start
        .subtract(Duration(days: 1))
        .toIso8601String()
        .toString();
    final end = _selectedDataRange?.end
        .add(Duration(days: 1))
        .toIso8601String()
        .toString();
    final QuerySnapshot<Map<String, dynamic>> snapshot = await attendanceRef
        .where("date", isGreaterThanOrEqualTo: start)
        .where("date", isLessThan: end)
        .get();

    snapshot.docs.forEach((doc) async {
      final data = doc.data();
      print("Document ID: ${doc.id}");
      print("Data: $data");
      final studentRef = doc.reference.collection("students");
      final studentSnapshot = await studentRef.get();
      final studentDocs = studentSnapshot.docs;
      studentDocs.forEach((studentDoc) {
        final studentData = studentDoc.data();
        print("Student data: $studentData");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance report'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: DateTimePickerButton(
              onDateRangeSelected: _handleDateRangeSelected,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('attendance')
                  .where('date',
                      isGreaterThanOrEqualTo: _selectedDataRange?.start)
                  .where('date', isLessThanOrEqualTo: _selectedDataRange?.end)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data?.docs;

                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Column 1')),
                      DataColumn(label: Text('Column 2')),
                      DataColumn(label: Text('Column 3')),
                    ],
                    rows: data.map((doc) {
                      final attendanceData = doc.data();

                      return DataRow(
                        cells: [
                          DataCell(Text(attendanceData['column1'].toString())),
                          DataCell(Text(attendanceData['column2'].toString())),
                          DataCell(Text(attendanceData['column3'].toString())),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
