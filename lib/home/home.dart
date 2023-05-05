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
import 'package:kpr_sports/settings/settings.dart';
import 'package:kpr_sports/shared/date_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHomePage = true;

  var Temp;
  String Name = "";

  @override
  void initState() {
    currentDate = DateTime.now();
    formatedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    day = DateFormat('EEEE').format(currentDate).substring(0, 3).toUpperCase();
    retrive();


  @override
  void initState() {

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
                    const Text(
                      "Hariharan.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isHomePage = true;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
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

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingsScreen()));
                      },
                      child: _navBar(
                          context,
                          !isHomePage,
                          'assets/Home/settings_icon.svg',
                          'assets/Home/select_icon.svg'),
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
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFE8E8E8), width: 1),

          ),
          elevation: 0,
          child: Container(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
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
                            subTitle,
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
    );


  }
}
