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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFF1b345f),
          secondaryHeaderColor: const Color(0xFF319753),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF142A50),
          )),
      routes: appRoutes,
      initialRoute: '/',
    );
  }
}
