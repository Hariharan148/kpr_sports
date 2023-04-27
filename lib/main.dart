import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpr_sports/routes.dart';
import 'package:kpr_sports/store/attendance_provider.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AttendanceProvider>(
        create: (_) => AttendanceProvider(),
      ),
      ChangeNotifierProvider<ReportProvider>(
        create: (_) => ReportProvider(),
      ),
      // add more providers as needed
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
