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
  
  @override
  void initState() {
    currentDate = DateTime.now();
    formatedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    day = DateFormat('EEEE').format(currentDate).substring(0, 3).toUpperCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromRGBO(255, 255, 255, 1.0),
        child: SafeArea(
          child: Column(children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/Home/Hello.svg'),
                      const Text(
                        "Pavan.",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 12),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
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
