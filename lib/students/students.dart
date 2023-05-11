import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/shared/appbar.dart';
import 'package:kpr_sports/shared/no_data.dart';
import 'package:kpr_sports/students/shimmer_students.dart';
import 'widgets.dart';
import 'students_model.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late Stream<List<UserModel>> _streamUser;
  int collectionSize = 0;
  bool _isfetching = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshAttendanceList();
    });
    _streamUser = allUser();
    getCollectionSizeStream().listen((size) {
      setState(() {
        collectionSize = size;
      });
    });
  }

  Stream<int> getCollectionSizeStream() {
    return FirebaseFirestore.instance
        .collection('students')
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<List<UserModel>> allUser() {
    return FirebaseFirestore.instance
        .collection("students")
        .orderBy('name', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  Future<void> _refreshAttendanceList() async {
    setState(() {
      _isfetching = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isfetching = false;
    });
  }

  imgselect(user) {
    if (user.image != null && user.image != "") {
      return Image.network(
        user.image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/pic.png");
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    } else {
      return Image.asset(
        "assets/pic.png",
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          const Text(
                            "Total students",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            "$collectionSize",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      InkWell(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserModel>>(
              stream: _streamUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: ShimmerCardStudent(
                    itemCount: 3,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else if (snapshot.data!.isEmpty) {
                  return const NoData(
                    height: 550,
                  );
                } else {
                  final userList = snapshot.data!;
                  return ListView.builder(
                    physics: const RangeMaintainingScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.grey, width: 1),
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
                                    backgroundColor: Colors.transparent,
                                    radius: 50.0,
                                    child: ClipOval(
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: imgselect(user)),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        popUp(context, user, userList, index);
                                      },
                                      icon:
                                          const Icon(Icons.more_vert_outlined))
                                ],
                              ),
                              fields(context, user),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
