import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class StudentAdd extends StatefulWidget {
  const StudentAdd({super.key});

  @override
  State<StudentAdd> createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Icon(Icons.expand_circle_down),
          ),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
                labelText: 'Student Name', border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: roll,
            decoration: const InputDecoration(
                labelText: "Roll No.", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: fname,
            decoration: const InputDecoration(
                labelText: "Father's Name", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: mname,
            decoration: const InputDecoration(
                labelText: "Mother's Name", border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: number,
            decoration: const InputDecoration(
                labelText: "Contact Number", border: OutlineInputBorder()),
          ),
          FloatingActionButton(
            onPressed: () {
              Map<String, dynamic> data = {
                "Name": name.text,
                "Roll No": roll.text,
                "FName": fname.text,
                "MName": mname.text,
                "Number": number.text
              };
              FirebaseFirestore.instance
                  .collection("Student")
                  // .doc(roll.text)
                  .add(data);
            },
            child: const Text("Submit"),
          ),
          FloatingActionButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("students")
                  .doc(roll.text)
                  .delete()
                  .then((value) => debugPrint("User Deleted"))
                  .catchError((onError) => debugPrint(onError));
            },
          )
        ]),
      ),
    );
  }
}
