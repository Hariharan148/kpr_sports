import "package:flutter/material.dart";
import "package:intl/intl.dart";

class DateBar extends StatefulWidget {
  const DateBar({super.key});

  @override
  State<DateBar> createState() => _DateBarState();
}

class _DateBarState extends State<DateBar> {
  String getDate() {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('dd/MMyyyy').format(today);
    return formattedDate;
  }

  String getDay() {
    DateTime today = DateTime.now();
    String day = DateFormat("EEEE").format(today);
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 110,
      child: Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1.0)),
        child: Column(
          children: [
            Text(
              getDate(),
              style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF319753),
                  decoration: TextDecoration.none),
            ),
            Text(
              getDay(),
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
