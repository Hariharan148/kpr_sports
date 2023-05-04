import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/home/home.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController name = TextEditingController();

  Future update() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('Faculty');
    final QuerySnapshot querySnapshot = await collection.get();
    final DocumentReference firstDoc = querySnapshot.docs.first.reference;
    await firstDoc.update({'Name': name.text});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_sharp)),
                    const Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Text(
                          "Settings",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 30),
                        ))
                  ],
                )),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 20),
                    child: Text(
                      "Update Name",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 1))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width - 200, top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        update();

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Set button color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Set border radius
                          side: const BorderSide(
                              color: Color.fromRGBO(49, 151, 83, 1),
                              width: 2), // Set border color and width
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ), // Set button text
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
