import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';



class WatchList extends StatefulWidget {
  const WatchList({super.key});

 

  @override
  State<WatchList> createState() => _WatchListState();

}

class _WatchListState extends State<WatchList> {
  String? errorMessage = ' ';
  String? successMessage = ' ';
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

  Widget _successMessage(){
    if (successMessage == null){
      return const SizedBox.shrink();
    }
    return Text(successMessage!);
  }

   Widget _errorMessage() {
    if (errorMessage == null) {
      return const SizedBox.shrink(); 
    }
    return Text(errorMessage!);
  }
  Widget _submitButton(){
    return ElevatedButton(onPressed: () async{
      setState((){
        errorMessage = null;
        successMessage = null;
      }
      );
      final id = _controllerID.text;
      final doc = await FirebaseFirestore.instance.collection('cards').doc(id).get();

   
      if (!doc.exists) {
        setState(() {
          errorMessage = 'Unable to find card id';
          successMessage = null;
        });
        return;
      }
    await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('watchlist')
      .doc(id)
      .set({
        'addedDate' : DateTime.now().toString(),
      });
      if (!mounted) return;
      setState(() {
        errorMessage = null;
        successMessage = 'Added Card';
      });
  
    }, child: const Text('Submit Card ID'),);
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
          ),
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
            _successMessage(),
            _submitButton(),
          ],
          ),

      )
    );
  }

}
