import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/attendence_report/date_time.dart';
import 'package:kpr_sports/services/report/table_fetch.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? _selectedDataRange;
  Map<String, Map<String, bool>> _studentDataMap = {};
  List<String> _dates = [];

  Future<void> _handleDateRangeSelected(DateTimeRange dateRange) async {
    setState(() {
      _selectedDataRange = dateRange;
    });
    try {
      final data = await fetchAttendanceData(_selectedDataRange);
      print("data $data");
      if (data != null) {
        setState(() {
          _studentDataMap =
              data['studentDataMap'] as Map<String, Map<String, bool>>;
          _dates = data['dates'] as List<String>;
        });
        print(_studentDataMap.entries);
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
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
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                ..._dates.map((date) => DataColumn(label: Text(date))).toList(),
              ],
              rows: _studentDataMap.entries
                  .map(
                    (entry) => DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        ..._dates.map(
                          (date) => DataCell(Text(entry.value[date] == true
                              ? 'Present'
                              : 'Absent')),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )),
        ],
      ),
    );
  }
}
