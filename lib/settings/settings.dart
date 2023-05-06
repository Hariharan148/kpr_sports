import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/home/home.dart';
import 'package:kpr_sports/shared/appbar.dart';
import 'package:kpr_sports/students/custom_text_fields.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController name = TextEditingController();
  final _nameUpdateKey = GlobalKey<FormState>();

  Future update() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('extras');
    final QuerySnapshot querySnapshot = await collection.get();
    final DocumentReference firstDoc = querySnapshot.docs.first.reference;
    await firstDoc.update({'name': name.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CustomAppBar(name: "Settings"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Update Name",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 70,
                  child: Form(
                    key: _nameUpdateKey,
                    child: TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Required";
                        } else if (value.length < 4) {
                          return "Enter Valid Name";
                        } else if (value.length > 12) {
                          return "Name Too Long (Max:12)";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final isValid = _nameUpdateKey.currentState!.validate();
                        if (isValid) {
                          _nameUpdateKey.currentState!.save();
                          // Handle button press

                          update();

                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(49, 151, 83, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color.fromRGBO(49, 151, 83, 1), width: 2),
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
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
