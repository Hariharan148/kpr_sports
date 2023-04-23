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
    return FirebaseFirestore.instance.collection("students").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Widget build(BuildContext context) {
    // final List<dynamic> documents = fetchRecords() as List;
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
                onPressed: () => showPopUp(context),
                child: const Icon(Icons.add),
              )),
          StreamBuilder<List<UserModel>>(
            stream: _streamUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
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
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text("${user.fname} ${user.mname}"),
                          trailing: Text(user.roll),
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

  void showPopUp(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: StudentAdd(),
        );
      });
}
