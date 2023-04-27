import 'package:flutter/material.dart';
import 'package:kpr_sports/attendence_report/data_table.dart';
import 'package:kpr_sports/attendence_report/date_time.dart';
import 'package:kpr_sports/services/report/table_fetch.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? _selectedDataRange;
  bool _isFetching = false;
  List<List<dynamic>>? _attendanceData;

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
      print('Error fetching attendance data: $e');
      setState(() {
        _attendanceData = null;
      });
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportProvider>(context, listen: false);

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
              onPressed: () {},
              child: const Text("Download"),
            ),
          ),
          if (_isFetching)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_attendanceData == null)
            const Center(
              child: Text('Error fetching attendance data'),
            )
          else if (_attendanceData!.isEmpty)
            const Center(
              child: Text('No attendance data available'),
            )
          else
            const Expanded(
              child: AttendanceData(),
            ),
        ],
      ),
    );
  }
}
