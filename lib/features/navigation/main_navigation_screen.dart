import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const screens = [
  Center(
    child: Text("Home"),
  ),
  Center(
    child: Text("Search"),
  ),
  Center(
    child: Text("Settings"),
  ),
  Center(
    child: Text("Home2"),
  ),
  Center(
    child: Text("Search2"),
  ),
  Center(
    child: Text("Settings2"),
  ),
];

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MainNavigationScreen',
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.teal,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.yellow,
            ),
            label: "Search",
          ),
        ],
      ),
    );
  }
}
