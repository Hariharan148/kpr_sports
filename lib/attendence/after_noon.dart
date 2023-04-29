import 'package:flutter/material.dart';

class AfterNoonWidget extends StatelessWidget {
  const AfterNoonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width - 50,
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width - 50,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD9D9D9), width: 2)),
          child: const Center(
              child: Text(
            "Attendance can't be taken after 12.00pm",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )),
        ),
      ),
    );
  }
}
