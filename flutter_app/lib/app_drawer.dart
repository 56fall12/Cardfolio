import 'package:flutter/material.dart';
import 'package:flutter_app/auth.dart';
import 'package:flutter_app/branding.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  Future<void> _signOut(BuildContext context) async {
    await Auth().signOut();
    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final email = Auth().currentUser?.email ?? 'Signed in';

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                children: [
                  const AppLogo(size: 48),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppBrand.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: 8),
            _DrawerDestination(
              icon: Icons.style_outlined,
              selectedIcon: Icons.style,
              label: 'Collection',
              selected: selectedIndex == 0,
              onTap: () => onDestinationSelected(0),
            ),
            _DrawerDestination(
              icon: Icons.visibility_outlined,
              selectedIcon: Icons.visibility,
              label: 'Watchlist',
              selected: selectedIndex == 1,
              onTap: () => onDestinationSelected(1),
            ),
            _DrawerDestination(
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              label: 'Settings',
              selected: selectedIndex == 2,
              onTap: () => onDestinationSelected(2),
            ),
            const Spacer(),
            const Divider(height: 1),
            ListTile(
              leading: Icon(Icons.logout, color: colorScheme.error),
              title: Text(
                'Sign out',
                style: TextStyle(color: colorScheme.error),
              ),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerDestination extends StatelessWidget {
  const _DrawerDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: Icon(selected ? selectedIcon : icon),
        title: Text(label),
        selected: selected,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
      ),
    );
  }
}
