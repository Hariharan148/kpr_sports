import 'package:flutter/material.dart';

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
    return Column(children: [
      ElevatedButton(
        onPressed: () async {
          final DateTimeRange? dateTimeRange = await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (dateTimeRange != null) {
            setState(() {
              selectedDates = dateTimeRange;
            });
            widget.onDateRangeSelected(dateTimeRange);
          }
        },
        child: const Text("Choose Date"),
      ),
      const SizedBox(height: 16),
      Text(
          "Selected dates: ${selectedDates.start.toIso8601String().substring(0, 10)} to ${selectedDates.end.toIso8601String().substring(0, 10)}")
    ]);
  }
}
