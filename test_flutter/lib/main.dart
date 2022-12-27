import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_flutter/firebase_options.dart';
import 'package:test_flutter/model/user_model.dart';
import 'package:test_flutter/suser_page.dart';
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
        './user/': (context) => const suserpage(),
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
        title: Text('CRUD Firebase'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                './adduser/',
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('./user/');
            },
            icon: Icon(Icons.add_home),
          ),
          IconButton(
            onPressed: () {
              updateuser();
            },
            icon: Icon(Icons.update),
          ),
          IconButton(
            onPressed: () {
              deleteuser();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: StreamBuilder(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;
            return ListView(
              children: users!.map(buildUser).toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong!${snapshot}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// body: FutureBuilder<List<User>>(
//   future: readUsers().first,

// stream builder (stream , builder) :- to have realtime stream of data
// future builder (future, builder) :- to have something in future

Widget buildUser(User user) => ListTile(
      leading: CircleAvatar(child: Text('$user.age')),
      title: Text(user.name),
      subtitle: Text(user.birthday),
    );

Stream<List<User>> readUsers() => FirebaseFirestore.instance
    .collection('users')
    .snapshots()
    .map(((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList()));

void updateuser() async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('ZJdOKxBX142X4jJ8bEbM');

//update specific fields
  docUser.update({
    'name': 'alex',
  });

  // delete fieldvalue :- 'name of field' :FieldValue.delete(),
  // nested city.name
  // doc.set :- will replace document
}

void deleteuser() async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc('ZJdOKxBX142X4jJ8bEbM');
//delete document
  docUser.delete();
}
