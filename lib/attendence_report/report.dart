import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpr_sports/attendence_report/data_table.dart';
import 'package:kpr_sports/attendence_report/date_time.dart';
import 'package:kpr_sports/attendence_report/excel_creator.dart';
import 'package:kpr_sports/attendence_report/shimmer_report.dart';
import 'package:kpr_sports/services/report/table_fetch.dart';
import 'package:kpr_sports/shared/appbar.dart';
import 'package:lottie/lottie.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? _selectedDataRange;
  bool isFetching = false;
  List<List<dynamic>>? _attendanceData = [];
  bool downloading = false;

  Future<void> _handleDateRangeSelected(DateTimeRange dateRange) async {
    setState(() {
      _selectedDataRange = dateRange;
      isFetching = true;
      _attendanceData = null;
    });
    try {
      final List<List<dynamic>>? data =
          await fetchAttendanceData(context, _selectedDataRange);
      setState(() {
        _attendanceData = data;
        _selectedDataRange = null;
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
        isFetching = false;
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CustomAppBar(name: "Report"),
      ),
      body: downloading
          ? Lottie.asset("assets/animation/basketball.json")
          : Column(
              children: [
                DateTimePickerButton(
                  onDateRangeSelected: _handleDateRangeSelected,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 30),
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF319753),
                          Color(0xFF4DC274)
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              shadowColor: Colors.transparent),
                          onPressed: () async {
                            setState(() {
                              downloading = true;
                            });
                            await Future.delayed(const Duration(seconds: 2));
                            downloadExcel(context);
                            setState(() {
                              downloading = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              Text("Download",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins")),
                            ],
                          )),
                    ),
                  ),
                ),
                if (isFetching)
                  const Center(
                    child: ShimmerWidgetReport(),
                  )
                else
                  Expanded(
                    child: RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      onRefresh: _refreshAttendanceData,
                      child: const AttendanceData(),
                    ),
                  ),
              ],
            ),
    );
  }
}
