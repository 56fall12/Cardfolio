import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/branding.dart';
import 'package:flutter_app/card_list_tile.dart';

class RemoveCardPage extends StatefulWidget {
  const RemoveCardPage({super.key});

  @override
  State<RemoveCardPage> createState() => _RemoveCardPageState();
}

class _RemoveCardPageState extends State<RemoveCardPage> {
  bool _fromCollection = true;

  CollectionReference<Map<String, dynamic>> _targetRef() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(_fromCollection ? 'collection' : 'watchlist');
  }

  Future<void> _confirmRemove(String cardId) async {
    final listName = _fromCollection ? 'collection' : 'watchlist';
    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove card?'),
          content: Text('Remove $cardId from your $listName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );

    if (shouldRemove != true) return;

    await _targetRef().doc(cardId).delete();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed $cardId from $listName')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove a card'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(
                  value: true,
                  label: Text('Collection'),
                  icon: Icon(Icons.style_outlined),
                ),
                ButtonSegment(
                  value: false,
                  label: Text('Watchlist'),
                  icon: Icon(Icons.visibility_outlined),
                ),
              ],
              selected: {_fromCollection},
              onSelectionChanged: (selection) {
                setState(() {
                  _fromCollection = selection.first;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _targetRef().snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return EmptyCardsState(
                    icon: _fromCollection
                        ? Icons.style_outlined
                        : Icons.visibility_outlined,
                    message: _fromCollection
                        ? 'No collection cards'
                        : 'No watchlist cards',
                    detail: 'There is nothing to remove from this list.',
                  );
                }

                final cards = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    final data = card.data() as Map<String, dynamic>?;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.catching_pokemon),
                        title: Text(card.id),
                        subtitle: Text(
                          formatAddedDate(data?['addedDate'] as String?),
                        ),
                        trailing: IconButton(
                          tooltip: 'Remove card',
                          icon: Icon(
                            Icons.delete_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => _confirmRemove(card.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
