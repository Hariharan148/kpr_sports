import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kpr_sports/students/students.dart';
import 'package:kpr_sports/attendence/attendence.dart';
import 'package:kpr_sports/attendence_report/report.dart';
import 'package:kpr_sports/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/students/students_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime currentDate;
  late String formatedDate;
  late String day;
  bool isHomePage = true;
  var Temp;
  String Name = "";

  @override
  void initState() {
    currentDate = DateTime.now();
    formatedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    day = DateFormat('EEEE').format(currentDate).substring(0, 3).toUpperCase();
    retrive();
    super.initState();
  }

  retrive() {
    FirebaseFirestore.instance
        .collection('Faculty')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      // Do something with the querySnapshot, like update a variable
      querySnapshot.docs.forEach((element) {
        setState(() {
          Temp = element.data()!;
          Name = Temp["Name"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromRGBO(255, 255, 255, 1.0),
        child: SafeArea(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontFamily: 'Poppins',
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..color = Colors.black
                              ..strokeWidth = 2,
                          ),
                        ),
                        const Text(
                          "Hello,",
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ]),
                      Text(
                        Name,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(20, 42, 80, 1), width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          formatedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            color: Color.fromRGBO(49, 151, 83, 1),
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          day,
                          style: const TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              color: Color.fromRGBO(168, 169, 172, 1),
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
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
            const SizedBox(
              height: 150,
            ),
            Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(20, 42, 80, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 20,
                      blurRadius: 50,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHomePage = true;
                        });
                      },
                      child: _navBar(
                          context,
                          isHomePage,
                          'assets/Home/home_icon.svg',
                          'assets/Home/select_icon.svg'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHomePage = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SettingsScreen()));
                          isHomePage = true;
                          // retrive();
                        });
                      },
                      child: _navBar(
                          context,
                          !isHomePage,
                          'assets/Home/settings_icon.svg',
                          'assets/Home/select_icon.svg'),
                    ),
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  Widget _navBar(BuildContext context, homePage, mainAsset, subAsset) {
    return Column(
      mainAxisAlignment:
          (homePage) ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
      children: [
        SvgPicture.asset(mainAsset),
        Visibility(visible: homePage, child: SvgPicture.asset(subAsset))
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 12),
            child: Row(
              children: [
                Stack(alignment: Alignment.center, children: [
                  SvgPicture.asset(background),
                  SvgPicture.asset(mainIcon)
                ]),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }
}
