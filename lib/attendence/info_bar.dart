import "package:flutter/material.dart";
import 'package:kpr_sports/store/attendance_provider.dart';

import "package:provider/provider.dart";

class InfoBar extends StatefulWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => _InfoBarState();
}

class _InfoBarState extends State<InfoBar> {
  late AttendanceProvider _attendanceProvider;

  @override
  void initState() {
    super.initState();
    _attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width - 50,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF142A50),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 80,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
              height: 50,
              width: 80,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
              height: 50,
              width: 80,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
    );
  }
}
