import 'package:kpr_sports/attendence/attendence.dart';
import 'package:kpr_sports/home/home.dart';
import 'package:kpr_sports/students/students.dart';
import 'package:kpr_sports/settings/settings.dart';
import 'package:kpr_sports/attendence_report/report.dart';

var appRoutes = {
  "/": (context) => const HomeScreen(),
  "/students": (context) => const StudentsScreen(),
  "/attendence": (context) => const AttendeceScreen(),
  "/report": (context) => const ReportScreen(),
  "/settings": (context) => const SettingsScreen()
};
