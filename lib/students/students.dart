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
                            children: const [
                              SizedBox(
                                height: 400,
                              ),
                            ],
                          );
                        }

                        return Card(
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 15),
                                      ),
                                      CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: img_select(user)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 78,
                                  ),
//WORKING CONTAINER--------------------------------------------------
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 50),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                      insetPadding:
                                                          const EdgeInsets
                                                                  .fromLTRB(
                                                              23, 52, 25, 30),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Container(
                                                        height: 308,
                                                        width: 380,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 26,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 28,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/cross.jpg'),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            CircleAvatar(
                                                                radius: 50.0,
                                                                backgroundImage:
                                                                    img_select(
                                                                        user)),
                                                            const SizedBox(
                                                              height: 15.25,
                                                            ),
                                                            Text(
                                                              "${user.name}",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 52,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: 120,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    gradient:
                                                                        const LinearGradient(
                                                                            colors: [
                                                                          Color(
                                                                              0xFFA8A9AC),
                                                                          Color(
                                                                              0xFFE0E1E2),
                                                                        ]),
                                                                  ),
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                    ),
                                                                    onPressed: () => showPopUp(
                                                                        context,
                                                                        true,
                                                                        userList,
                                                                        index),
                                                                    child:
                                                                        const Text(
                                                                      "Edit",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 23,
                                                                ),
                                                                Container(
                                                                  width: 120,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    gradient:
                                                                        const LinearGradient(
                                                                            colors: [
                                                                          Color(
                                                                              0xFF319753),
                                                                          Color(
                                                                              0xFF4DC274),
                                                                        ]),
                                                                  ),
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      shadowColor:
                                                                          Colors
                                                                              .transparent,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Student")
                                                                          .doc(user
                                                                              .uid)
                                                                          .delete()
                                                                          .then((value) =>
                                                                              print(user.uid));
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Delete",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                });
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.more_vert_outlined)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 8.0),
                                  Text(
                                    "Name : ${user.name}",
                                    style: const TextStyle(
                                        fontSize: 16.0, fontFamily: "Poppins"),
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
                                ],
                              ),
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
                        Container(
                          margin: const EdgeInsets.only(left: 25),
                          child: InkWell(
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
              insetPadding: const EdgeInsets.fromLTRB(23, 52, 25, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                width: 500,
                child: StudentAdd(
                  edit: verify ?? false,
                  usr: userList ?? [],
                  index: index ?? 0,
                ),
              ));
        });
  }
}
