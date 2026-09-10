import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
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
            ListTile(leading: Icon(Icons.circle), title: Text("Dfsdfsf")),
            ListTile(leading: Icon(Icons.circle), title: Text("sdfsdfdsdf")),
            ListTile(leading: Icon(Icons.circle), title: Text("Sylveon")),
          ],
        ),
      ),
    );
  }
}
