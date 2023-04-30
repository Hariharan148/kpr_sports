import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpr_sports/attendence_report/data_table.dart';
import 'package:kpr_sports/attendence_report/date_time.dart';
import 'package:kpr_sports/attendence_report/excel_creator.dart';
import 'package:kpr_sports/services/report/table_fetch.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? _selectedDataRange;
  bool _isFetching = false;
  List<List<dynamic>>? _attendanceData = [];

  Future<void> _handleDateRangeSelected(DateTimeRange dateRange) async {
    setState(() {
      _selectedDataRange = dateRange;
      _isFetching = true;
    });
    try {
      final List<List<dynamic>>? data =
          await fetchAttendanceData(context, _selectedDataRange);
      setState(() {
        _attendanceData = data;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching attendance data',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  Future<void> _refreshAttendanceData() async {
    try {
      final List<List<dynamic>>? data =
          await fetchAttendanceData(context, _selectedDataRange);
      setState(() {
        _attendanceData = data;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching attendance data',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance report'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: DateTimePickerButton(
              onDateRangeSelected: _handleDateRangeSelected,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                downloadExcel(context);
              },
              child: const Text("Download"),
            ),
          ),
          if (_isFetching)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_attendanceData == [])
            const Text('No attendance data available')
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshAttendanceData,
                child: AttendanceData(),
              ),
            ),
        ],
      ),
    );
  }
}
