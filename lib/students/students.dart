import 'package:kpr_sports/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'students_add.dart';
import 'students_model.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late Stream<List<UserModel>> _streamUser;

  @override
  void initState() {
    _streamUser = allUser();

    super.initState();
  }

  Stream<List<UserModel>> allUser() {
    return FirebaseFirestore.instance.collection("Student").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  img_select(user) {
    if (user.image != null) {
      return NetworkImage(user.image);
    } else {
      return const AssetImage("assets/empty_pic.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final List<dynamic> documents = fetchRecords() as List;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<List<UserModel>>(
              stream: _streamUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No Data Found"),
                  );
                } else {
                  final userList = snapshot.data!;
                  // print(snapshot.data);
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        if (index == 0) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 400,
                              ),
                              Container(
                                width: 10,
                              ),
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      "All students",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: img_select(user)),
                              const SizedBox(height: 8.0),
                              Text(
                                "Name : ${user.name}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Roll No. : ${user.roll}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Section : ${user.sec}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Sport : ${user.sport}",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Email: ${user.email}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Parent's email: ${user.pemail}",
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Phone number: ${user.phone}',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                "Parent's phone number: ${user.pphone}",
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Student")
                                            .doc(user.uid)
                                            .delete()
                                            .then((value) => print(user.uid));
                                      },
                                      child: const Icon(Icons.delete)),
                                  OutlinedButton(
                                      onPressed: () => showPopUp(
                                          context, true, userList, index),
                                      child: const Icon(Icons.edit))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Container(
              color: Colors.white.withOpacity(1),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, left: 10, bottom: 30),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.black,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(45, 20, 105, 40),
                    height: 45,
                    width: 180,
                    child: const Text(
                      "Students List",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 120,
//----------------BLACK CARD STARTS FROM HERE--------------------------------
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 182,
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 105,
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(45, 10, 45, 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xFF142A50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 25, 60, 0),
                                child: const Text(
                                  "Total students",
                                  style: TextStyle(color: Colors.white),
                                )),
                            Container(
                              margin:
                                  const EdgeInsets.only(right: 140, left: 25),
                              child: const Text(
                                "52",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showPopUp(context);
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF319753),
                                      Color(0xFF55F68B),
                                    ]),
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                border: Border.all(width: 0),
                                borderRadius: BorderRadius.circular(35)),
                            child: const Icon(
                              Icons.add,
                              size: 50,
                              color: Color(0xFF142A50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPopUp(BuildContext context, [verify, userList, index]) {
    // final check = verify;
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              child: StudentAdd(
            edit: verify ?? false,
            usr: userList ?? [],
            index: index ?? 0,
          ));
        });
  }
}
