import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 30),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            height: 35,
            width: 35,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              splashColor: Colors.white12,
            ),
          ),
        ));
  }
}
