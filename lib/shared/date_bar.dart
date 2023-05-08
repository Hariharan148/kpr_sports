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
    String formattedDate = DateFormat('dd/MM/yyyy').format(today);
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
      height: 40,
      width: 90,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getDate(),
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: Color(0xFF319753),
                  decoration: TextDecoration.none),
            ),
            Text(
              getDay(),
              style: const TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: Colors.grey,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
