import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Setting extends StatelessWidget {
  const Setting({super.key, required this.title});

  final String title;

  Future<void> signOut(BuildContext context) async {
  await Auth().signOut();
  if (context.mounted) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}

  Widget _title() {
    return const Text('Settings');
  }

  Widget _signOutButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () => signOut(context),
    child: const Text('Sign Out'),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}