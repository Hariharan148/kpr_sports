import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpr_sports/attendence/after_noon.dart';
import 'package:kpr_sports/attendence/attendance_list.dart';
import 'package:kpr_sports/attendence/bottom_bar.dart';
import 'package:kpr_sports/attendence/info_bar.dart';
import 'package:kpr_sports/shared/no_data.dart';
import 'package:kpr_sports/services/attendance/init_helper.dart';
import 'package:kpr_sports/services/attendance/submit_helper.dart';
import 'package:kpr_sports/shared/appbar.dart';
import 'package:kpr_sports/shared/date_bar.dart';
import 'package:kpr_sports/attendence/shimmer_attendance.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceProvider _attendanceProvider;
  bool _isfetching = false;

  bool allPresent = false;

  bool submitting = false;

  bool success = false;

  bool get isAfterNoon {
    final currentTime = DateTime.now();
    return currentTime.hour < 12;
  }

  void updateStatus(ispresent) {
    if (!ispresent) {
      setState(() {
        allPresent = false;
      });

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
      Fluttertoast.showToast(
        msg: 'Error: ${error.toString()}',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFD9887C),
      );

      setState(() {
        _isfetching = false;
      });
    }
  }

  Future<void> _onSubmit() async {
    try {
      final attendanceProvider =
          Provider.of<AttendanceProvider>(context, listen: false);

      setState(() {
        submitting = true;
      });

      await AttendanceService.submitAttendance(attendanceProvider);

      setState(() {
        submitting = false;
      });

      Fluttertoast.showToast(
        msg: 'Attendance submitted successfully',
        gravity: ToastGravity.BOTTOM,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error: ${error.toString()}',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFFD9887C),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    if (!isAfterNoon) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshAttendanceList();
        _attendanceProvider.presentVal = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: CustomAppBar(name: "Attendance"),
        ),
        body: isAfterNoon
            ? const AfterNoonWidget()
            : !submitting
                ? _attendanceProvider.attendanceStatus.isNotEmpty
                    ? Column(
                        children: [
                          const InfoBar(),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 15),
                            child: SizedBox(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: Checkbox(
                                              value: allPresent,
                                              checkColor: Colors.white,
                                              activeColor:
                                                  const Color(0xFF142A50),
                                              onChanged: (value) {
                                                setState(() {
                                                  allPresent = value!;
                                                });
                                                updateStatus(value);
                                              },
                                            ),
                                          ),
                                          const Text(
                                            "All present",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const DateBar()
                                  ],
                                )),
                          ),
                          Expanded(
                            child: RefreshIndicator(
                                onRefresh: _refreshAttendanceList,
                                color: Theme.of(context).primaryColor,
                                child: isAfterNoon
                                    ? const AfterNoonWidget()
                                    : _isfetching
                                        ? Center(
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  400,
                                              width: double.infinity,
                                              child: const ShimmerCardList(
                                                itemCount: 5,
                                              ),
                                            ),
                                          )
                                        : const SingleChildScrollView(
                                            physics:
                                                AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics(),
                                            ),
                                            child: AttendanceList())),
                          )
                        ],
                      )
                    : const NoData(
                        height: 250,
                      )
                : Center(
                    child: Lottie.asset("assets/animation/basketball.json"),
                  ),
        bottomNavigationBar: !isAfterNoon
            ? submitting
                ? null
                : _attendanceProvider.attendanceStatus.isNotEmpty
                    ? CustomBottomBar(
                        onCancelPressed: () {
                          updateStatus(false);
                        },
                        onSubmitPressed: _onSubmit)
                    : null
            : null);
  }
}
