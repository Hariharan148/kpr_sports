import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:provider/provider.dart';

class AttendanceData extends StatefulWidget {
  const AttendanceData({Key? key}) : super(key: key);

  @override
  State<AttendanceData> createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  // [
  //   'Student Name',
  //   '2023-04-22',
  //   '2023-04-23',
  //   '2023-04-24',
  //   '2023-04-25'
  // ];

  // [
  //   ['hari', 'false', 'true', 'false', 'true'],
  //   ['pavan', 'true', 'true', 'false', 'false'],
  //   ['suraj', 'true', 'true', 'false', 'false'],
  //   ['asdfasf', 'false', 'false', 'false', 'false'],
  //   ['asdf', 'false', 'false', 'false', 'false'],
  //   ['asdc', 'false', 'false', 'false', 'false'],
  //   ['asdfa', 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  //   ["hell", 'false', 'false', 'false', 'false'],
  // ];

  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>>? tableData =
        context.watch<ReportProvider>().studentData;

    final List<String> headers = [
      "Students Name",
      ...context.watch<ReportProvider>().dates
    ];

    if (tableData!.isEmpty) {
      return const Center(
        child: Text('No Data'),
      );
    }

    return Expanded(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 600,
        isFixedHeader: true,
        headerWidgets: _buildHeaderWidgets(headers),
        leftSideChildren: _buildLeftSideItems(tableData),
        rightSideChildren: _buildRightSideItems(tableData),
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
      ),
    );
  }

  List<Widget> _buildHeaderWidgets(List<String> headers) {
    if (headers.isEmpty) {
      return [];
    }
    return headers
        .map(
          (header) => Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              header,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildLeftSideItems(List<List<dynamic>> tableData) {
    if (tableData.isEmpty) {
      return [];
    }
    return tableData
        .map(
          (data) => Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              data[0]!,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildRightSideItems(List<List<dynamic>> tableData) {
    return tableData.map((data) {
      return SizedBox(
        width: 600,
        child: Row(
          children: data
              .skip(1)
              .map((cell) => Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      cell ?? '-',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
    }).toList();
  }
}
