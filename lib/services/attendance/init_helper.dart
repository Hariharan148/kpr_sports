import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference students =
    FirebaseFirestore.instance.collection("students");

void getAttendanceStatus(
  Function(List<Map<String, dynamic>>)? onSuccess,
  Function(dynamic)? onError,
) {
  print("in");
  students.orderBy("name").get().then((QuerySnapshot querySnapshot) {
    final attendenceStatus = querySnapshot.docs
        .map((doc) => {
              "uid": doc.id,
              "name": doc["name"],
              "rollno": doc["rollno"],
              "status": false,
            })
        .toList();
    onSuccess?.call(attendenceStatus);
    print("out");
  }).catchError((error) {
    print("error in ");
    onError?.call(error);
  });
}
