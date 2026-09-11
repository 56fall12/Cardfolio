import 'package:flutter/material.dart';
import 'package:flutter_app/addCardPage.dart';
import 'package:flutter_app/addWatchlist.dart';
import 'package:flutter_app/app_drawer.dart';
import 'package:flutter_app/collectionPage.dart';
import 'package:flutter_app/watchlistPage.dart';
import 'package:flutter_app/settings.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const _titles = ['Collection', 'Watchlist', 'Settings'];

  static const _pages = <Widget>[
    CollectionPage(),
    WatchlistPage(),
    Setting(),
  ];

  void _selectDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: AppDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          Navigator.pop(context);
          _selectDestination(index);
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: _selectedIndex == 2
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _selectedIndex == 0
                        ? const addCardPage()
                        : const WatchList(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(_selectedIndex == 0 ? 'Add card' : 'Watch card'),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectDestination,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style),
            label: 'Collection',
          ),
          NavigationDestination(
            icon: Icon(Icons.visibility_outlined),
            selectedIcon: Icon(Icons.visibility),
            label: 'Watchlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
