import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class addCardPage extends StatefulWidget {
  const addCardPage({super.key});


  

  @override
  State<addCardPage> createState() => _addCardPageState();

}

class _addCardPageState extends State<addCardPage> {
  String? errorMessage = ' ';
  final TextEditingController _controllerID = TextEditingController();
  
  Widget _title(){
    return const Text('Please enter card ID');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      );
  }

   Widget _errorMessage() {
    if (errorMessage == null) {
      return const SizedBox.shrink(); 
    }
    return Text(errorMessage!);
  }
  Widget _submitButton(){
    return ElevatedButton(onPressed: () async{
      final id = _controllerID.text;
      final doc = await FirebaseFirestore.instance.collection('cards').doc(id).get();

   
      if (!doc.exists) {
        setState(() {
          errorMessage = 'Unable to find card id';
        });
        return;
      }

    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('collection')
      .doc(id)
      .set({
        'addedDate' : DateTime.now().toString(),
      });
    setState((){
      errorMessage = null;
    });

    Navigator.pop(context);

    }, child: const Text('Submit Card ID'),);
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('Enter ID here', _controllerID),
            _errorMessage(),
            _submitButton(),
          ],
          ),

      )
    );
  }

}