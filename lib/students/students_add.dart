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
  String Img = "";
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

  void uploadImg() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("/Profile_Images/img_pic_${generateRandomText(5)}.jpg");
    await ref.putFile(File(Img));

    await ref.getDownloadURL().then((value) {
      link = value;
      FirebaseFirestore.instance.collection("Student").add(toMap());
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

  void saveImg() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("/Profile_Images/img_pic_${generateRandomText(5)}.jpg");
    await ref.putFile(File(Img));
    await ref.getDownloadURL().then((value) {
      link = value;
      FirebaseFirestore.instance
          .collection("Student")
          .doc(widget.usr[widget.index].uid)
          .set(toMap(), SetOptions(merge: true));
    });
  }

  check() {
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
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    "Add New Student",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
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
                      radius: 50.0,
                      backgroundImage: (ch) ? check() : NetworkImage(Img),
                    )
                  ],
                )),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    nameField(
                      control: name,
                      lableText: "Name",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width - 100,
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
                      height: 5,
                    ),
                    sportField(
                      verti: 30,
                      control: sport,
                      lableText: "Sport",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    emailField(
                      verti: 30,
                      control: email,
                      lableText: "Email",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    emailField(
                      verti: 30,
                      control: pemail,
                      lableText: "Parent's Email",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    phoneField(
                      control: phone,
                      lableText: "Phone",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    phoneField(
                      control: pphone,
                      lableText: "Parent's Phone",
                      inputTextColor: Colors.black,
                      barColor: Colors.black,
                    ),
                  ],
                )),
            const SizedBox(
              height: 85,
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
                      gradient: const LinearGradient(
                          // begin: Alignment.topLeft,
                          // end: Alignment.bottomRight,
                          colors: [
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          // begin: Alignment.topLeft,
                          // end: Alignment.bottomRight,
                          colors: [
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
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.edit,
              child: Row(
                children: [
                  const SizedBox(
                    width: 45,
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          // begin: Alignment.topLeft,
                          // end: Alignment.bottomRight,
                          colors: [
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
                        style: TextStyle(color: Colors.black),
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
                      gradient: const LinearGradient(
                          // begin: Alignment.topLeft,
                          // end: Alignment.bottomRight,
                          colors: [
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
                          // if (ch == true) {
                          saveImg();
                          // }

                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.black),
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
