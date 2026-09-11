import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/branding.dart';

class AddCardFormPage extends StatefulWidget {
  const AddCardFormPage({
    super.key,
    required this.title,
    required this.headline,
    required this.description,
    required this.icon,
    required this.targetCollection,
    required this.successMessage,
  });

  final String title;
  final String headline;
  final String description;
  final IconData icon;
  final String targetCollection;
  final String successMessage;

  @override
  State<AddCardFormPage> createState() => _AddCardFormPageState();
}

class _AddCardFormPageState extends State<AddCardFormPage> {
  String? errorMessage;
  String? successMessage;
  bool _isSubmitting = false;
  final TextEditingController _controllerID = TextEditingController();

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final id = _controllerID.text.trim();
    if (id.isEmpty) {
      setState(() {
        errorMessage = 'Enter a card ID first';
        successMessage = null;
      });
      return;
    }

    setState(() {
      errorMessage = null;
      successMessage = null;
      _isSubmitting = true;
    });

    try {
      final doc =
          await FirebaseFirestore.instance.collection('cards').doc(id).get();

      if (!doc.exists) {
        setState(() {
          errorMessage = 'Unable to find card ID';
          successMessage = null;
          _isSubmitting = false;
        });
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(widget.targetCollection)
          .doc(id)
          .set({
        'addedDate': DateTime.now().toString(),
      });

      if (!mounted) return;
      setState(() {
        errorMessage = null;
        successMessage = widget.successMessage;
        _isSubmitting = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Something went wrong. Try again.';
        successMessage = null;
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                widget.icon,
                size: 36,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.headline,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _controllerID,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _isSubmitting ? null : _submit(),
                    decoration: InputDecoration(
                      labelText: 'Card ID',
                      hintText: 'e.g. swsh4-25',
                      prefixIcon: const Icon(Icons.tag),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (errorMessage != null) ...[
                    const SizedBox(height: 12),
                    StatusBanner(
                      message: errorMessage!,
                      isError: true,
                    ),
                  ],
                  if (successMessage != null) ...[
                    const SizedBox(height: 12),
                    StatusBanner(
                      message: successMessage!,
                      isError: false,
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _isSubmitting ? null : _submit,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add),
                    label: Text(_isSubmitting ? 'Adding...' : 'Add card'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
