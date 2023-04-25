import 'package:flutter/material.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:kpr_sports/attendence/checkbox.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({Key? key}) : super(key: key);

  @override
  _AttendanceListState createState() => _AttendanceListState();
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

    return ListView.builder(
      itemCount: attendanceStatus.length,
      itemBuilder: (BuildContext context, int index) {
        final name = attendanceStatus[index]["name"] as String?;
        final rollno = attendanceStatus[index]["rollno"] as String?;
        final status = attendanceStatus[index]["status"] as bool?;

        return Card(
          child: InkWell(
            child: ListTile(
              title: Text(name ?? "No Name"),
              subtitle: Text(rollno ?? "No Roll No"),
              trailing: AttendanceCheckbox(
                index: index,
                status: status ?? false,
              ),
            ),
          ),
        );
      },
    );
  }
}
