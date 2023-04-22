import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello\nHariharan"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/students");
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Students"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/attendance");
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Attendence"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/report");
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text("Attendence Report"),
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
      ]),
    );
  }
}
