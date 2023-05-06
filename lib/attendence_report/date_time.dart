import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerButton extends StatefulWidget {
  final void Function(DateTimeRange dateRange) onDateRangeSelected;

  const DateTimePickerButton({Key? key, required this.onDateRangeSelected})
      : super(key: key);

  @override
  State<DateTimePickerButton> createState() => _DateTimePickerButtonState();
}

class _DateTimePickerButtonState extends State<DateTimePickerButton> {
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    final formattedStartDate =
        DateFormat('M/d/yyyy').format(selectedDates.start);
    final formattedEndDate = DateFormat('M/d/yyyy').format(selectedDates.end);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 150,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final DateTimeRange? dateTimeRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(3000),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          elevatedButtonTheme: ElevatedButtonThemeData(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shadowColor: Colors.transparent)),
                          scaffoldBackgroundColor: Colors.grey[50],
                          dividerColor: Colors.grey,
                          colorScheme: ColorScheme.fromSwatch().copyWith(
                            primary: Theme.of(context).primaryColor,
                            onSurface: Colors.black,
                            onPrimary: Colors.white,
                          ),
                        ),
                        child: child!,
                      );
                    });
                if (dateTimeRange != null) {
                  setState(() {
                    selectedDates = dateTimeRange;
                  });
                  widget.onDateRangeSelected(dateTimeRange);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.edit_calendar_outlined),
                  Text(
                    "Choose date",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 150,
            height: 54,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          formattedStartDate,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "To",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          formattedEndDate,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
