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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: "Home",
            tooltip: "What are you?",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: "Search",
            tooltip: "What are you?",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.gear,
              ),
              label: "Settings",
              tooltip: "What are you?",
              backgroundColor: Colors.brown),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: "Home2",
            tooltip: "What are you?",
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            label: "Search2",
            tooltip: "What are you?",
            backgroundColor: Colors.deepPurple,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.gear,
            ),
            label: "Settings2",
            tooltip: "What are you?",
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
