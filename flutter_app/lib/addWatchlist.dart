import 'package:flutter/material.dart';
import 'package:flutter_app/add_card_form.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddCardFormPage(
      title: 'Add to watchlist',
      headline: 'Track a card\'s price',
      description:
          'Enter a card ID to watch market prices without adding it to your collection.',
      icon: Icons.visibility,
      targetCollection: 'watchlist',
      successMessage: 'Added to your watchlist',
    );
  }
}
