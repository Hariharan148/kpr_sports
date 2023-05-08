import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AttendanceData extends StatefulWidget {
  const AttendanceData({Key? key}) : super(key: key);

  @override
  State<AttendanceData> createState() => _AttendanceDataState();
}

class _AttendanceDataState extends State<AttendanceData> {
  @override
  Widget build(BuildContext context) {
    final List<List<dynamic>>? tableData =
        context.watch<ReportProvider>().studentData;

    final List<String> headers = [
      "NAME",
      ...context.watch<ReportProvider>().dates
    ];

    if (tableData!.isEmpty) {
      return Lottie.asset("assets/animation/nodata.json");
    }

    double getWidth() {
      return 100.0 * (headers.length - 1);
    }

    double getHeight() {
      return 50.0 * (tableData.length + 1);
    }

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
      child: SizedBox(
        height: getHeight(),
        width: MediaQuery.of(context).size.width - 50,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: const Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFA8A9AC), width: 1.0)),
          child: HorizontalDataTable(
            leftHandSideColBackgroundColor: const Color(0xFFF3F5F7),
            rightHandSideColBackgroundColor: const Color(0xFFF3F5F7),
            itemCount: tableData.length,
            leftHandSideColumnWidth: 120,
            rightHandSideColumnWidth: getWidth(),
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
                color: Color(0xFF142A50),
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
    return tableData.asMap().entries.map((entry) {
      int index = entry.key;
      List<dynamic> data = entry.value;
      return Row(
        children: [
          Container(
            width: 20,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "${index + 1}.",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text(
              "${data[0]!}",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  List<Widget> _buildRightSideItems(List<List<dynamic>> tableData) {
    return tableData.map((data) {
      return SizedBox(
        width: 600,
        child: Row(
          children: data.skip(1).map((cell) {
            return Container(
              width: 100,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                cell ?? '-',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  color: cell == "Present"
                      ? Colors.green
                      : cell == "Absent"
                          ? Colors.red[200]
                          : Colors.black,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
