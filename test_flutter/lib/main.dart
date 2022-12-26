import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter/firebase_options.dart';
import 'package:test_flutter/user_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        './adduser/': (context) => const UserPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Type name here'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('./adduser', ((route) => false));
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

Future createuser({required String name}) async {
// Reference to document
  //final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
  final docUser = FirebaseFirestore.instance.collection('users');
  // final json = {
  //   'name': name,
  //   'age': 21,
  //   'birthday': DateTime(2001, 7, 28),
  // };

  final user = User(
    id: docUser.id,
    name: name,
    age: 21,
    birthday: DateTime(2001, 7, 28),
  );

  final json = user.toJson();

  //create document and write data to firebase
  await docUser.add(json);
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };
}
