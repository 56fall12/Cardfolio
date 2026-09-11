import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/addCardPage.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/settings.dart';
import 'package:flutter_app/card_detail.dart';
import 'package:flutter_app/addWatchlist.dart';


class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key, required this.title});

  final String title;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  Widget _buildCollectionList(){
    //build the collection list and get the information from the database to display 
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('collection')
      .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
        return const Center(child: Text('No cards yet'));
      }
      final cards = snapshot.data!.docs;
      return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index){
          final card = cards[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardDetail(cardId: card.id))
              );
            },
            child:ListTile(title: Text(card.id)),
              );
            },
          );
        },
      );
  }

Widget _buildWatchlistList(){
    //build the watch list and get the information from the database to display 
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('watchlist')
      .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
        return const Center(child: Text('No cards yet'));
      }
      final cards = snapshot.data!.docs;
      return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index){
          final card = cards[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardDetail(cardId: card.id))
              );
            },
            child:ListTile(title: Text(card.id)),
              );
            },
          );
        },
      );
  }

    @override
  Widget build(BuildContext context) {
    //build the tabs and update the navigation 
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Collection'),
              Tab(text: 'Watchlist'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting(title: 'Settings')),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildCollectionList(),
            _buildWatchlistList(),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                final currentIndex = DefaultTabController.of(context).index;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => currentIndex == 0 ? const addCardPage() : const WatchList(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ), 
    ); 
  } 
} 