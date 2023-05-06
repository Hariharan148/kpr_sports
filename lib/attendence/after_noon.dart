import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AfterNoonWidget extends StatelessWidget {
  const AfterNoonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Lottie.asset("assets/animation/timer.json"),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width - 50,
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 50,
              child: Container(
                decoration: BoxDecoration(

                    // color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xFFA8A9AC), width: 1)),
                child: const Center(
                    child: Text(
                  "Attendance can't be taken after 12.00 pm",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
