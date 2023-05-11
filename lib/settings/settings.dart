import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpr_sports/shared/appbar.dart';

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
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 60,
                  child: Form(
                    key: _nameUpdateKey,
                    child: TextFormField(
                      maxLength: 13,
                      cursorColor: const Color.fromARGB(66, 110, 110, 110),
                      controller: name,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        errorStyle: TextStyle(fontSize: 0.01),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Required";
                        } else if (value.length < 4) {
                          return "Enter Valid Name";
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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
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
                        onPressed: () {
                          final isValid =
                              _nameUpdateKey.currentState!.validate();
                          if (isValid) {
                            _nameUpdateKey.currentState!.save();

                            update();

                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
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
