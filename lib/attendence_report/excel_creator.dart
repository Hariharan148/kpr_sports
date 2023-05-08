import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kpr_sports/store/report_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

Future<void> downloadExcel(BuildContext context) async {
  try {
    print("hello");

    final report = Provider.of<ReportProvider>(context, listen: false);

    final List<List<dynamic>>? tableData = report.studentData;
    final List<String> headers = ["Student Name", ...report.dates];

    if (tableData!.isEmpty) {
      Fluttertoast.showToast(
        msg: 'No attendance data available to download',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];

    for (var i = 0; i < headers.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
    }

    for (var i = 0; i < tableData.length; i++) {
      for (var j = 0; j < tableData[i].length; j++) {
        sheet.getRangeByIndex(i + 2, j + 1).setText(tableData[i][j].toString());
      }
    }

    final List<int> bytes = workbook.saveAsStream();

    final PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getPath_2();

      final filePath =
          '$directory/${headers[1]}${headers[1] == headers[headers.length - 1] ? "" : " to ${headers[headers.length - 1]}"}.xlsx';
      print(filePath);
      await File(filePath).writeAsBytes(bytes);
      Fluttertoast.showToast(
        msg: 'Excel file downloaded successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      checkPermissions(context);
    }

    workbook.dispose();
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error occurred while downloading excel file',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}

Future<String> getPath_2() async {
  var path = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  return path;
}

Future<void> checkPermissions(BuildContext context) async {
  final PermissionStatus status = await Permission.storage.status;

  if (status.isPermanentlyDenied) {
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Storage permission'),
          content: const Text(
              'Please go to app settings and grant storage permission manually.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
