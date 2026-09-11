import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/branding.dart';
import 'package:flutter_app/card_detail.dart';
import 'package:flutter_app/card_list_tile.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('watchlist')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const EmptyCardsState(
            icon: Icons.visibility_outlined,
            message: 'Nothing on your watchlist',
            detail: 'Tap Watch card to follow a price.',
          );
        }
        final cards = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 88),
          itemCount: cards.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: Text(
                  'Watching ${cards.length} ${cards.length == 1 ? 'card' : 'cards'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              );
            }
            final card = cards[index - 1];
            final data = card.data() as Map<String, dynamic>?;
            return CardListTile(
              cardId: card.id,
              subtitle: formatAddedDate(data?['addedDate'] as String?),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardDetail(cardId: card.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
