import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_flutter/model/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(hintText: 'enter name'),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerAge,
            decoration: InputDecoration(hintText: 'enter age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerDate,
            decoration: InputDecoration(hintText: 'BirthDay'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              final user = User(
                name: controllerName.text,
                age: int.parse(controllerAge.text),
                birthday: controllerAge.text,
              );

              createuser(user);
              Navigator.pop(context);
            },
            child: Text('Create'),
          )
        ],
      ),
    );
  }
}

Future createuser(User user) async {
  // // Reference to document
//   //final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  user.id = docUser.id;

  final json = user.toJson();
  await docUser.set(json);
}
