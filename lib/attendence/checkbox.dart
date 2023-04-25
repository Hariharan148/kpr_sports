import 'package:flutter/material.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceCheckbox extends StatefulWidget {
  const AttendanceCheckbox({
    Key? key,
    required this.index,
    required this.status,
  }) : super(key: key);

  final int index;
  final bool status;

  @override
  _AttendanceCheckboxState createState() => _AttendanceCheckboxState();
}

class _AttendanceCheckboxState extends State<AttendanceCheckbox> {
  late bool _status;

  @override
  void initState() {
    _status = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("checkbox building");
    final attendanceProvider = context.watch<AttendanceProvider>();
    final attendanceStatus = attendanceProvider.attendanceStatus;

    return Checkbox(
      value: _status,
      onChanged: (value) {
        setState(() {
          _status = value!;
          attendanceStatus[widget.index]["status"] = value;
          attendanceProvider.attendanceStatusList = attendanceStatus;
        });
      },
    );
  }
}
