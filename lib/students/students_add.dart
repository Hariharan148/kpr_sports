import 'dart:io';
import 'dart:math';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController sec = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pemail = TextEditingController();
  TextEditingController sport = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pphone = TextEditingController();
  String Img = "";
  String filePath = "";
  String result = "";
  late File _image;
  String link = "";
  bool ch = true;

  @override
  void initState() {
    // pickUploadImage();
    if (widget.edit) {
      final user = widget.usr[widget.index];
      name.text = user.name;
      roll.text = user.roll;
      sec.text = user.sec;
      email.text = user.email;
      pemail.text = user.pemail;
      sport.text = user.sport;
      phone.text = user.phone;
      pphone.text = user.pphone;
      // print(Img);

      setState(() {
        if (user.image != "") {
          ch = false;
          Img = user.image;
        }
      });
    }

    super.initState();
  }

  String generateRandomText(int length) {
    final random = Random();
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final text =
        List.generate(length, (_) => charset[random.nextInt(charset.length)])
            .join();
    return text;
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      _image = File(image.path);

      setState(() {
        if (widget.edit) {
          ch = true;
        }
        Img = image.path;
        filePath = "Image_img.jpg";
      });
    }
  }

  void uploadImg() {
    final ref =
        FirebaseStorage.instance.ref().child("/Profile_Images/img_pic.jpg");
    ref.putFile(File(Img));
    print(
        "-------------------------------------------------------------------------");
    ref.getDownloadURL().then((value) {
      link = value;
      FirebaseFirestore.instance.collection("Student").add(toMap());
      print(
          "-------------------------------------------------------------------------");
    });
  }

  toMap() {
    Map<String, dynamic> data = {
      "Image": link,
      "Name": name.text,
      "Roll No": roll.text,
      "Section": sec.text,
      "Sport": sport.text,
      "Email": email.text,
      "PEmail": pemail.text,
      "Phone": phone.text,
      "PPhone": pphone.text
    };
    return data;
  }

  void saveImg() {
    final ref = FirebaseStorage.instance
        .ref()
        .child("/Profile_Images/img_pic.jpg");
    ref.putFile(File(Img));
    ref.getDownloadURL().then((value) {
      link = value;
      FirebaseFirestore.instance
          .collection("Student")
          .doc(widget.usr[widget.index].uid)
          // .doc(roll.text)
          .set(toMap(), SetOptions(merge: true));
    });
  }

  check() {
    // if (widget.edit) {
    //   setState(() {
    //     ch = true;
    //   });
    // }
    return (Img == "")
        ? const AssetImage("assets/empty_pic.jpg")
        : FileImage(_image);
  }

  textField(control, text) {
    return TextFormField(
      controller: control,
      decoration:
          InputDecoration(labelText: text, border: const OutlineInputBorder()),
    );
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
                      backgroundImage: (ch) ? check() : NetworkImage(Img),
                    )
                  ],
                )),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    textField(name, "Test Name"),
                    textField(roll, "Roll No."),
                    textField(sec, "Section"),
                    textField(sport, "Sport"),
                    textField(email, "Email"),
                    textField(pemail, "Parent's Email"),
                    textField(phone, "Phone"),
                    textField(pphone, "Parent's Phone"),
                  ],
                )),
            Visibility(
              visible: !widget.edit,
              child: FloatingActionButton(
                onPressed: () {
                  uploadImg();
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ),
            Visibility(
              visible: widget.edit,
              child: FloatingActionButton(
                onPressed: () {
                  saveImg();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
