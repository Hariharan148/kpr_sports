import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kpr_sports/students/students_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpr_sports/students/custom_text_fields.dart';

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
  String img = "";
  String filePath = "";
  String result = "";
  late File _image;
  String link = "";
  bool ch = true;

  @override
  void initState() {
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

      setState(() {
        if (user.image != "") {
          ch = false;
          img = user.image;
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
        img = image.path;
        filePath = "Image_img.jpg";
      });
    }
  }

  void uploadImg() async {
    final id = generateRandomText(7);
    var ref;
    if (img != "") {
      final ref = FirebaseStorage.instance
          .ref()
          .child("/Profile_Images/img_pic_$id.jpg");
      await ref.putFile(File(img));
      await ref.getDownloadURL().then((value) {
        link = value;
        FirebaseFirestore.instance
            .collection("students")
            .doc(id)
            .set(toMap(id));
      });
    } else {
      link = "";
      FirebaseFirestore.instance.collection("students").doc(id).set(toMap(id));
    }
  }

  toMap(id) {
    Map<String, dynamic> data = {
      "id": id,
      "image": link,
      "name": name.text,
      "rollno": roll.text,
      "section": sec.text,
      "sport": sport.text,
      "email": email.text,
      "parentEmail": pemail.text,
      "phone": phone.text,
      "parentPhone": pphone.text
    };
    return data;
  }

  void saveImg() async {
    var ref;
    if (img != "" && ch == true) {
      final ref = FirebaseStorage.instance
          .ref()
          .child("/Profile_Images/img_pic_${widget.usr[widget.index].uid}.jpg");
      await ref.putFile(File(img));
      await ref.getDownloadURL().then((value) {
        link = value;
        FirebaseFirestore.instance
            .collection("students")
            .doc(widget.usr[widget.index].uid)
            .set(toMap(widget.usr[widget.index].uid), SetOptions(merge: true));
      });
    } else {
      link = widget.usr[widget.index].image;
      FirebaseFirestore.instance
          .collection("students")
          .doc(widget.usr[widget.index].uid)
          .set(toMap(widget.usr[widget.index].uid), SetOptions(merge: true));
    }
  }

  check() {
    return (img == "") ? const AssetImage("assets/pic.png") : FileImage(_image);
  }

  Widget textField(control, text) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: control,
        decoration: InputDecoration(
          labelText: text,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    "Add New Student",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Poppins"),
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel_outlined,
                      size: 25,
                    ))
              ],
            ),
            const SizedBox(
              height: 11.06,
            ),
            const SizedBox(
              width: 286.01,
              child: Divider(
                thickness: 0.2,
                color: Colors.black,
              ),
            ),
            GestureDetector(
                onTap: () {
                  pickUploadImage();
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50.0,
                      backgroundImage: (ch) ? check() : NetworkImage(img),
                    )
                  ],
                )),
            Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      nameField(
                        control: name,
                        lableText: "Name",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rollField(
                            verti: 30,
                            horizo: 140,
                            control: roll,
                            lableText: "Roll No.",
                            inputTextColor: Colors.black,
                            barColor: Colors.black,
                          ),
                          sectionField(
                            verti: 30,
                            horizo: 100,
                            control: sec,
                            lableText: "Section",
                            inputTextColor: Colors.black,
                            barColor: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      sportField(
                        verti: 30,
                        control: sport,
                        lableText: "Sport",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      emailField(
                        verti: 30,
                        control: email,
                        lableText: "Email",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      emailField(
                        control: pemail,
                        lableText: "Parent's Email",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      phoneField(
                        control: phone,
                        lableText: "Phone",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      phoneField(
                        control: pphone,
                        lableText: "Parent's Phone",
                        inputTextColor: Colors.black,
                        barColor: Colors.black,
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              width: 286.01,
              child: Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !widget.edit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFA8A9AC),
                        Color(0xFFE0E1E2),
                      ]),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFF319753),
                        Color(0xFF4DC274),
                      ]),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          _formKey.currentState!.save();

                          uploadImg();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.edit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFA8A9AC),
                        Color(0xFFE0E1E2),
                      ]),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 11,
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color(0xFF319753),
                        Color(0xFF4DC274),
                      ]),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          _formKey.currentState!.save();

                          saveImg();

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
