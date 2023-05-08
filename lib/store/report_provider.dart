import "package:flutter/material.dart";

class ReportProvider extends ChangeNotifier {
  List<List<dynamic>>? _studentData = [];
  List<String> _dates = [];

  List<List<dynamic>>? get studentData => _studentData;
  List<String> get dates => _dates;

  set setStudentData(List<List<dynamic>>? value) {
    _studentData = value;
    notifyListeners();
  }

  set setDates(List<String> value) {
    _dates = value;
    notifyListeners();
  }
}
