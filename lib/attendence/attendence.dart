import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  CollectionReference students =
      FirebaseFirestore.instance.collection("students");

  late List<Map<String, dynamic>> attendenceStatus = [];

  @override
  void initState() {
    super.initState();
    students.get().then((QuerySnapshot querySnapshot) {
      setState(() {
        attendenceStatus = querySnapshot.docs
            .map((doc) => {
                  "uid": doc.id,
                  "name": doc["name"],
                  "rollno": doc["rollno"],
                  "status": false,
                })
            .toList();
      });
    });
  }

  bool get isBeforeNoon {
    final currentTime = DateTime.now();
    print(DateTime.now().hour);
    print(currentTime.hour);
    return currentTime.hour > 12;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
      ),
      body: isBeforeNoon ? const BeforeNoonWidget() : buildAttendanceList(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          color: Colors.blue,
          child: InkWell(
            onTap: () async {
              print(attendenceStatus);
              final today = DateTime.now().toString().substring(0, 10);
              final attendanceRef = FirebaseFirestore.instance
                  .collection("attendance")
                  .doc(today)
                  .collection("students");

              await Future.wait(attendenceStatus
                  .map((status) => attendanceRef.doc(status["uid"]).set({
                        "attendanceStatus": status["status"],
                        "name": status["name"],
                        "rollno": status["rollno"],
                      })));
              print("Attendance submitted successfully");
            },
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAttendanceList() {
    return FutureBuilder<QuerySnapshot>(
      future: students.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final students = snapshot.data!.docs;

        return ListView.builder(
          itemCount: students.length,
          itemBuilder: (BuildContext context, int index) {
            final name = students[index].get("name") as String?;
            final rollno = students[index].get("rollno") as String?;

            print(name);
            print(rollno);
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        final newStatus = !attendenceStatus[index]["status"];
                        attendenceStatus[index]["status"] = newStatus;
                      });
                    },
                    child: ListTile(
                      title: Text(name ?? "No Name"),
                      subtitle: Text(rollno ?? "No Roll No"),
                      trailing: attendenceStatus[index]["status"]
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class BeforeNoonWidget extends StatelessWidget {
  const BeforeNoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Attendance can only be taken after 12pm.',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
