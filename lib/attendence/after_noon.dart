import 'package:flutter/material.dart';

class AfterNoonWidget extends StatelessWidget {
  const AfterNoonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width - 50,
      child: Container(
        child: const Center(
          child: Text(
            'Attendance can only be taken before 12pm.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
