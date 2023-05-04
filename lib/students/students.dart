import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/shared/appbar.dart';
import 'widgets.dart';
import 'students_add.dart';
import 'students_model.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late Stream<List<UserModel>> _streamUser;
  int collectionSize = 0;

  @override
  void initState() {
    _streamUser = allUser();
    getCollectionSizeStream().listen((size) {
    setState(() {
      collectionSize = size;
    });
  });

  
    super.initState();
  }

  Stream<int> getCollectionSizeStream() {
  return FirebaseFirestore.instance.collection('Student').snapshots().map((snapshot) => snapshot.size);
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
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: CustomAppBar(name: "Students"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                height: 100,
                child: Card(
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xFF142A50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: const Text(
                              "Total students",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            )),
                            Container(
                              child: Text(
                                "$collectionSize",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              showPopUp(context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
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
                                size: 40,
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
                  // length_state(userList);
                  // print(snapshot.data);
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: img_select(user)),
                                    IconButton(
                                        onPressed: () {
                                          // setState(() {
                                          PopUp(context, user, userList, index);
                                          // });
                                        },
                                        icon: const Icon(
                                            Icons.more_vert_outlined))
                                  ],
                                ),
                                Fields(context, user),
                              ],
                            ),
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
      ),
    );
  }
}
