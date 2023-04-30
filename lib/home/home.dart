import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    currentDate = DateTime.now();
    formatedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    day = DateFormat('EEEE').format(currentDate).substring(0, 3).toUpperCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1.0),
      child: SafeArea(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      "Hariharan.",
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(20, 42, 80, 1), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$formatedDate",
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
                        "${day}",
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
          _buildMenuCard("Students List", "/students", context,
              "assets/Home/add_background.svg", "assets/Home/add.svg"),
          _buildMenuCard(
              "Attendence",
              "/attendance",
              context,
              "assets/Home/attendance_background.svg",
              "assets/Home/attendance.svg"),
          _buildMenuCard("Attendence Report", "/report", context,
              "assets/Home/report_background.svg", "assets/Home/report.svg"),
          SizedBox(
            height: 100,
          ),
          Container(
              // color: Color.fromRGBO(20, 42, 80, 1),
              // padding: EdgeInsets.symmetric(vertical: 1000),
              height: 70,
              width: 300,
              // color: Color.fromRGBO(20, 42, 80, 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(20, 42, 80, 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHomePage = true;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: (isHomePage)
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/Home/home_icon.svg'),
                        Visibility(
                            visible: isHomePage,
                            child:
                                SvgPicture.asset('assets/Home/select_icon.svg'))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isHomePage = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: (!isHomePage)
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/Home/settings_icon.svg'),
                        Visibility(
                            visible: !isHomePage,
                            child:
                                SvgPicture.asset('assets/Home/select_icon.svg'))
                      ],
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }

  // selectPage() {
  //   if (!isHomePage) {
  //     return SvgPicture.asset('assets/Home/select_icon.svg');
  //   } else {
  //     return Container();
  //   }
  // }

  Widget _buildMenuCard(String title, String routeName, BuildContext context,
      background, mainIcon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            // side: const BorderSide(color: Colors.grey, width: 1),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SvgPicture.asset(background),
                  SvgPicture.asset(mainIcon)
                ]),
                Padding(
                  padding: EdgeInsets.only(left: 30),
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
