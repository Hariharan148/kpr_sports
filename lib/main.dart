import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpr_sports/firebase_options.dart';
import 'package:kpr_sports/routes.dart';
import 'package:kpr_sports/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: appRoutes,
      // initialRoute: '/',
      home: SplashScreen(),
    );
  }
}
