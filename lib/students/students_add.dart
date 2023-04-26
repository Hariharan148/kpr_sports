import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpr_sports/students/students_model.dart';
import 'package:image_picker/image_picker.dart';

class StudentAdd extends StatefulWidget {
  final bool edit;
  final List usr;
  final int index;

  const StudentAdd(
      {super.key, required this.edit, required this.usr, required this.index});

  @override
  State<StudentAdd> createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController mname = TextEditingController();
  TextEditingController number = TextEditingController();
  String Img = "";

  @override
  void initState() {
    if (widget.edit) {
      final user = widget.usr[widget.index];
      name.text = user.name;
      roll.text = user.roll;
      fname.text = user.fname;
      mname.text = user.mname;
      number.text = user.number;
      print(Img);
      setState(() {
        if (user.image != null) {
          Img = user.image;
        }
      });
    }

    super.initState();
  }

  void pickUploadImage() async {
    print("Hello");
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    final ref = FirebaseStorage.instance.ref().child("image_$name.jpg");

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        Img = value;
      });
    });
  }

check() {
    return (Img == "") ? const AssetImage("assets/empty_pic.jpg") : NetworkImage(Img);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.expand_circle_down),
            ),
            GestureDetector(
                onTap: () {
                  pickUploadImage();
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: check(),
                    )
                  ],
                )),
            ListView(shrinkWrap: true, children: [
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
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: number,
                decoration: const InputDecoration(
                    labelText: "Contact Number", border: OutlineInputBorder()),
              ),
              Visibility(
                visible: !widget.edit,
                child: FloatingActionButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "Image": Img,
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
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"),
                ),
              ),
              Visibility(
                visible: widget.edit,
                child: FloatingActionButton(
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "Image": Img,
                      "Name": name.text,
                      "Roll No": roll.text,
                      "FName": fname.text,
                      "MName": mname.text,
                      "Number": number.text
                    };
                    FirebaseFirestore.instance
                        .collection("Student")
                        .doc(widget.usr[widget.index].uid)
                        // .doc(roll.text)
                        .set(data, SetOptions(merge: true));
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
