import 'package:flutter/material.dart';
import 'package:kpr_sports/attendence/after_noon.dart';
import 'package:kpr_sports/attendence/attendance_list.dart';
import 'package:kpr_sports/services/attendance/init_helper.dart';
import 'package:kpr_sports/services/attendance/submit_helper.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceProvider _attendanceProvider;
  bool _isfetching = false;
  bool get isBeforeNoon {
    final currentTime = DateTime.now();
    return currentTime.hour > 12;
  }

  Future<void> _refreshAttendanceList() async {
    setState(() {
      _isfetching = true;
    });

    try {
      getAttendanceStatus((status) {
        setState(() {
          _attendanceProvider.attendanceStatusList = status;
          _isfetching = false;
        });
      }, (error) {
        throw error;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isfetching = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    if (!isBeforeNoon) {
      _refreshAttendanceList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendance"),
        ),
        body: RefreshIndicator(
            onRefresh: _refreshAttendanceList,
            child: isBeforeNoon
                ? const AfterNoonWidget()
                : _isfetching
                    ? const Center(child: CircularProgressIndicator())
                    : _attendanceProvider.attendanceStatus.isNotEmpty
                        ? const AttendanceList()
                        : _isfetching
                            ? const Center(child: CircularProgressIndicator())
                            : const Text("no data")),
        bottomNavigationBar: !isBeforeNoon
            ? BottomAppBar(
                child: Container(
                  height: 50.0,
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () async {
                      try {
                        final attendanceProvider =
                            Provider.of<AttendanceProvider>(context,
                                listen: false);
                        await AttendanceService.submitAttendance(
                            attendanceProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Attendance submitted successfully"),
                          ),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${error.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              )
            : null);
  }
}
