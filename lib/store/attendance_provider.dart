import "package:flutter/material.dart";

class AttendanceProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _attendanceStatus = [];
  bool _loading = false;

  bool get loading => _loading;

  List<Map<String, dynamic>> get attendanceStatus => _attendanceStatus;

  set attendanceStatusList(List<Map<String, dynamic>> value) {
    _attendanceStatus = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
