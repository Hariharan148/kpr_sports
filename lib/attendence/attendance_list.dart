import 'package:flutter/material.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({Key? key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = context.watch<AttendanceProvider>();
    final attendanceStatus = attendanceProvider.attendanceStatus;

    if (attendanceStatus.isEmpty) {
      return const Center(
        child: Text("No data!"),
      );
    }

    return SizedBox(
      height: 400,
      width: 300,
      child: ListView.builder(
        itemCount: attendanceStatus.length,
        itemBuilder: (BuildContext context, int index) {
          final name = attendanceStatus[index]["name"] as String?;
          final rollno = attendanceStatus[index]["rollno"] as String?;
          bool status = attendanceStatus[index]["status"];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFA8A9AC), width: 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: InkWell(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "No Name",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        rollno ?? "No Roll No",
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  status = !status;
                  attendanceStatus[index]["status"] = status;
                  attendanceProvider.attendanceStatusList = attendanceStatus;
                  if (status) {
                    attendanceProvider.increment();
                  } else {
                    attendanceProvider.decrement();
                  }
                },
                trailing: Theme(
                  data: Theme.of(context).copyWith(
                    checkboxTheme: CheckboxThemeData(
                      checkColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Color(0xFFA8A9AC))),
                    ),
                  ),
                  child: Checkbox(
                    value: status,
                    fillColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).primaryColor),
                    onChanged: (value) {
                      status = value!;
                      attendanceStatus[index]["status"] = value;
                      attendanceProvider.attendanceStatusList =
                          attendanceStatus;
                      if (value) {
                        attendanceProvider.increment();
                      } else {
                        attendanceProvider.decrement();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
