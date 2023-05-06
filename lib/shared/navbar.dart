import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.homePage,
    required this.mainAsset,
    required this.subAsset,
  });

  final homePage;
  final mainAsset;
  final subAsset;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return _navBar(context, widget.homePage, widget.mainAsset, widget.subAsset);
  }
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
