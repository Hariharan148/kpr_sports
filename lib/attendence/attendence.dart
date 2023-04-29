import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpr_sports/attendence/after_noon.dart';
import 'package:kpr_sports/attendence/attendance_list.dart';
import 'package:kpr_sports/attendence/bottom_bar.dart';
import 'package:kpr_sports/services/attendance/init_helper.dart';
import 'package:kpr_sports/services/attendance/submit_helper.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceProvider _attendanceProvider;
  bool _isfetching = false;
  bool allPresent = false;
  bool get isBeforeNoon {
    final currentTime = DateTime.now();
    return currentTime.hour < 12;
  }

  void updateStatus(ispresent) {
    if (!ispresent) {
      allPresent = false;
      for (var set in _attendanceProvider.attendanceStatus) {
        set["status"] = false;
        _attendanceProvider.presentVal = 0;
      }
    } else {
      for (var set in _attendanceProvider.attendanceStatus) {
        set["status"] = true;
        _attendanceProvider.presentVal =
            _attendanceProvider.attendanceStatus.length;
      }
    }

    _attendanceProvider.attendanceStatusList =
        _attendanceProvider.attendanceStatus;
  }

  String getDate() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    return formattedDate;
  }

  String getDay() {
    DateTime today = DateTime.now();
    String day = DateFormat("EEEE").format(today);
    return day;
  }

  Future<void> _refreshAttendanceList() async {
    setState(() {
      _isfetching = true;
      allPresent = false;
    });

    try {
      getAttendanceStatus((status) {
        setState(() {
          _attendanceProvider.presentVal = 0;
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshAttendanceList();
        _attendanceProvider.presentVal = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 120,
            centerTitle: true,
            title: const Text(
              "Attendance",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                height: 35,
                width: 35,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  splashColor: Colors.white12,
                ),
              ),
            )),
        body: Column(
          children: [
            SizedBox(
              height: 80,
              width: MediaQuery.of(context).size.width - 50,
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFF142A50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "Poppins"),
                              ),
                              Text(
                                "${_attendanceProvider.attendanceStatus.length}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Text(
                                "Present",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "Poppins"),
                              ),
                              Text(
                                "${context.watch<AttendanceProvider>().present}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const Text(
                                "Absent",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "Poppins"),
                              ),
                              Text(
                                "${_attendanceProvider.attendanceStatus.length - _attendanceProvider.present}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 5),
              child: SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 120,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: allPresent,
                                checkColor: Colors.white,
                                activeColor: const Color(0xFF142A50),
                                onChanged: (value) {
                                  allPresent = value!;
                                  updateStatus(value);
                                },
                              ),
                            ),
                            const Text(
                              "All present",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 1.0)),
                          child: Column(
                            children: [
                              Text(
                                getDate(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                getDay(),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            RefreshIndicator(
                onRefresh: _refreshAttendanceList,
                child: isBeforeNoon
                    ? const AfterNoonWidget()
                    : _isfetching
                        ? const Center(child: CircularProgressIndicator())
                        : _attendanceProvider.attendanceStatus.isNotEmpty
                            ? const AttendanceList()
                            : _isfetching
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : const Text("no data")),
          ],
        ),
        bottomNavigationBar: !isBeforeNoon
            ? CustomBottomBar(
                onCancelPressed: () {
                  updateStatus(false);
                },
                onSubmitPressed: () async {
                  try {
                    final attendanceProvider =
                        Provider.of<AttendanceProvider>(context, listen: false);

                    await AttendanceService.submitAttendance(
                        attendanceProvider);

                    Fluttertoast.showToast(
                      msg: 'Attendance submitted successfully',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                    );
                  } catch (error) {
                    Fluttertoast.showToast(
                      msg: 'Error: ${error.toString()}',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red[150],
                    );
                  }
                },
              )
            : null);
  }
}
