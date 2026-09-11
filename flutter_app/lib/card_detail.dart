import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/auth.dart';


class CardDetail extends StatelessWidget {
  const CardDetail({
    super.key,
    required this.cardId,
    this.userId,
  });
  final String? userId;
  final String cardId;

  Future<QuerySnapshot> fetchUserData() async {
    return await FirebaseFirestore.instance
      .collection('cards')
      .doc(cardId)
      .collection('price_history')
      .get();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(appBar:  AppBar(
      title: Text('Card Details $cardId'),
      leading: IconButton(icon: const Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.of(context).pop();
      },)
    ),
     body: FutureBuilder<QuerySnapshot>(
      future: fetchUserData(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return const Center (child: CircularProgressIndicator());
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];

            final data = doc.data() as Map<String, dynamic>;
            final dateKey = doc.id;
            final price = data['price'] ?? '0.00';
            return ListTile(
              title: Text('\$$price'),
              subtitle: Text(dateKey),
              leading: const Icon(Icons.trending_up),
            );
          },
        );
      }
     ),
    );
  }
}

