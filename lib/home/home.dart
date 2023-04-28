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
        toolbarHeight: 150,
        title: const Text(
          "Hello\nHariharan",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, "/students");
          //   },
          //   child: Card(
          //     child: Container(
          //       padding: const EdgeInsets.all(16.0),
          //       child: const Text("Students"),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, "/attendance");
          //   },
          //   child: Card(
          //     child: Container(
          //       padding: const EdgeInsets.all(16.0),
          //       child: const Text("Attendence"),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, "/report");
          //   },
          //   child: Card(
          //     child: Container(
          //       padding: const EdgeInsets.all(16.0),
          //       child: const Text("Attendence Report"),
          //     ),
          //   ),
          // )
          _buildMenuCard("Students", "/students", context),
          _buildMenuCard("Attendence", "/attendance", context),
          _buildMenuCard("Attendence Report", "/report", context)
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
      ]),
    );
  }

  Widget _buildMenuCard(String title, String routeName, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(title),
        ),
      ),
    );
  }
}
