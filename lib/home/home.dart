import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kpr_sports/shared/date_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isHomePage = true;

  @override
  void initState() {
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
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 25, bottom: 25),
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
                    ],
                  ),
                  const DateBar()
                ],
              ),
            ),
            _buildMenuCard("Students", "மாணவர்கள்", "/students", context,
                "assets/Home/add_background.svg", "assets/Home/add.svg"),
            _buildMenuCard(
                "Attendence",
                "பள்ளி வருகை",
                "/attendance",
                context,
                "assets/Home/attendance_background.svg",
                "assets/Home/attendance.svg"),
            _buildMenuCard(
                "Attendence Report",
                "கால பதிவு அறிக்கை",
                "/report",
                context,
                "assets/Home/report_background.svg",
                "assets/Home/report.svg"),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
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
                  )),
            )
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

  Widget _buildMenuCard(String title, String subTitle, String routeName,
      BuildContext context, background, mainIcon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
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
