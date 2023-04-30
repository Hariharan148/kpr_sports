import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:kpr_sports/routes.dart';
import 'package:kpr_sports/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HomeScreen()),
)
);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: RiveAnimation.asset('assets/Home/radioSplashAnimation.riv'),
    );
  }
}
