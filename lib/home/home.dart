import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kpr_sports/attendence/attendence.dart';
import 'package:kpr_sports/attendence_report/report.dart';
import 'package:kpr_sports/settings/settings.dart';
import 'package:kpr_sports/shared/date_bar.dart';
import 'package:kpr_sports/shared/navbar.dart';
import 'package:kpr_sports/students/students.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHomePage = true;

  var Temp;
  String name = "Loading.....";

  @override
  void initState() {
    retrive();
    super.initState();
  }

  retrive() {
    FirebaseFirestore.instance
        .collection('extras')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      // Do something with the querySnapshot, like update a variable
      for (var element in querySnapshot.docs) {
        setState(() {
          Temp = element.data()!;
          name = Temp["name"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      color: const Color.fromRGBO(255, 255, 255, 1.0),
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 28,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.black,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const DateBar()
              ],
            ),
          ),
          _buildMenuCard("Students List", const StudentsScreen(), context,
              "assets/Home/add_background.svg", "assets/Home/add.svg"),
          _buildMenuCard(
              "Attendence",
              const AttendanceScreen(),
              context,
              "assets/Home/attendance_background.svg",
              "assets/Home/attendance.svg"),
          _buildMenuCard("Attendence Report", const ReportScreen(), context,
              "assets/Home/report_background.svg", "assets/Home/report.svg"),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 70,
                width: MediaQuery.of(context).size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(20, 42, 80, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isHomePage == true) {
                          setState(() {
                            isHomePage = true;
                          });
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: NavBar(
                          homePage: isHomePage,
                          mainAsset: 'assets/Home/home_icon.svg',
                          subAsset: 'assets/Home/select_icon.svg'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHomePage = false;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()));

                        setState(() {
                          isHomePage = true;
                        });
                      },
                      child: NavBar(
                          homePage: !isHomePage,
                          mainAsset: 'assets/Home/settings_icon.svg',
                          subAsset: 'assets/Home/select_icon.svg'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
      String title, Route, BuildContext context, background, mainIcon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Route),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE8E8E8), width: 1),
          ),
          elevation: 0,
          child: SizedBox(
            height: 87,
            width: MediaQuery.of(context).size.width - 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFF1F0F5),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: Offset(2, 2),
                    ),
                  ]),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        SvgPicture.asset(background),
                        SvgPicture.asset(mainIcon)
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Color(0xFF212121),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Color(0xFFA8A9AC),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
