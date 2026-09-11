import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/card_list_tile.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({
    super.key,
    required this.cardId,
    this.userId,
  });
  final String? userId;
  final String cardId;

  Future<QuerySnapshot> fetchPriceHistory() {
    return FirebaseFirestore.instance
        .collection('cards')
        .doc(cardId)
        .collection('price_history')
        .get();
  }

  double? _parsePrice(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll('\$', '').trim());
    }
    return null;
  }

  String _formatPrice(double? value) {
    if (value == null) return '—';
    return '\$${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Price history'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: fetchPriceHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return EmptyCardsState(
              message: 'Could not load prices',
              detail: '${snapshot.error}',
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = [...snapshot.data!.docs]
            ..sort((a, b) => a.id.compareTo(b.id));

          if (docs.isEmpty) {
            return const EmptyCardsState(
              message: 'No price history yet',
              detail: 'Prices will show up here once this card has market data.',
            );
          }

          final prices = docs
              .map((doc) => _parsePrice((doc.data() as Map<String, dynamic>)['price']))
              .whereType<double>()
              .toList();
          final latest = prices.isNotEmpty ? prices.last : null;
          final high = prices.isEmpty
              ? null
              : prices.reduce((a, b) => a > b ? a : b);
          final low = prices.isEmpty
              ? null
              : prices.reduce((a, b) => a < b ? a : b);
          final first = prices.isNotEmpty ? prices.first : null;
          final change = latest != null && first != null ? latest - first : null;
          final changeLabel = change == null
              ? '—'
              : '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}';

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Card(
                color: colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardId,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatPrice(latest),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Latest market price',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'High',
                      value: _formatPrice(high),
                      icon: Icons.arrow_upward,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      label: 'Low',
                      value: _formatPrice(low),
                      icon: Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      label: 'Change',
                      value: changeLabel,
                      icon: Icons.trending_up,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...docs.reversed.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final price = _parsePrice(data['price']);
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.secondaryContainer,
                      child: Icon(
                        Icons.attach_money,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    title: Text(
                      _formatPrice(price),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(doc.id),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Column(
          children: [
            Icon(icon, size: 18, color: colorScheme.primary),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
