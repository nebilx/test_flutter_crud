import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:test_flutter/main.dart';
import 'package:test_flutter/model/user_model.dart';

class suserpage extends StatefulWidget {
  const suserpage({super.key});

  @override
  State<suserpage> createState() => _suserpageState();
}

class _suserpageState extends State<suserpage> {
  final controllerString = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single User'),
      ),
      body: FutureBuilder<User?>(
        future: readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('something went wrong $snapshot'),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data;
            return user == null
                ? Center(child: Text('No User'))
                : buildUser(user);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<User?> readUser() async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('aPFDHurrKbv8EcnHh2QP');

  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return User.fromJson(snapshot.data()!);
  }
}
