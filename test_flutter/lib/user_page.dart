import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final contollerName = TextEditingController();
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
            decoration: const InputDecoration(hintText: 'enter name'),
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(hintText: 'enter age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(hintText: 'BirthDay'),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            child: Text('Create'),
          )
        ],
      ),
    );
  }
}
