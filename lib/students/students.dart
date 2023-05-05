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

  imgselect(user) {
    if (user.image != null) {
      return NetworkImage(user.image);
    } else {
      return const AssetImage("assets/empty_pic.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () => showPopUp(
                  context,
                ),
                child: const Icon(Icons.add),
              )),
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
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                                radius: 50.0, backgroundImage: imgselect(user)),
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
        ],
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
