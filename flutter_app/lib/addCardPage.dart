import 'package:flutter/material.dart';
import 'package:flutter_app/add_card_form.dart';

class addCardPage extends StatelessWidget {
  const addCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddCardFormPage(
      title: 'Add to collection',
      headline: 'Save a card you own',
      description:
          'Enter a card ID from the catalog to add it to your collection.',
      icon: Icons.style,
      targetCollection: 'collection',
      successMessage: 'Added to your collection',
    );
  }
}
