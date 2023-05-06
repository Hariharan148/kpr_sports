import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpr_sports/students/students_add.dart';
import 'package:kpr_sports/students/students.dart';

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

img_select(user) {
  if (user.image != null && user.image != "") {
    return Image.network(
      user.image,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
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
      "assets/empty_pic.jpg",
      fit: BoxFit.cover,
    );
  }
}

Future PopUp(BuildContext context, user, userList, index) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: const EdgeInsets.fromLTRB(23, 52, 25, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/cross.jpg'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    child: ClipOval(
                      child: SizedBox(
                          width: 100, height: 100, child: img_select(user)),
                    ),
                  ),
                  const SizedBox(
                    height: 15.25,
                  ),
                  Text(
                    "${user.name}",
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    "${user.roll}",
                    style: const TextStyle(fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () {
                            Navigator.pop(context);
                            showPopUp(context, true, userList, index);
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 23,
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
                            FirebaseFirestore.instance
                                .collection("Student")
                                .doc(user.uid)
                                .delete()
                                .then((value) => Navigator.pop(context));
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      });
}

Widget Fields(BuildContext context, user) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 30.0),
      Text(
        "${user.name}",
        style: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
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
  );
}
