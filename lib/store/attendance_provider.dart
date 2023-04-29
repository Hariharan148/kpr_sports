import "package:flutter/material.dart";

class AttendanceProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _attendanceStatus = [];
  bool _loading = false;

  bool get loading => _loading;

  int _present = 0;

  int get present => _present;

  set presentVal(int value) {
    _present = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> get attendanceStatus => _attendanceStatus;

  set attendanceStatusList(List<Map<String, dynamic>> value) {
    _attendanceStatus = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void increment() {
    _present++;
    notifyListeners();
  }

  void decrement() {
    _present--;
    notifyListeners();
  }
}
