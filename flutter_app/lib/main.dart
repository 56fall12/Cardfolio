import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/addCardPage.dart';
import 'package:flutter_app/widget_tree.dart';
import 'collectionPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        colorScheme: .fromSeed(seedColor: Colors.deepPurpleAccent),
      ),
      home: const addCardPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    const title = "Collection";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView(
          children: const <Widget>[
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
          ],
        ),
      ),
    );
  }
}
