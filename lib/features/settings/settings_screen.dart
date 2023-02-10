import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: ListWheelScrollView(
        // offAxisFraction: 2,
        diameterRatio: 10,
        useMagnifier: true,
        magnification: 2,
        itemExtent: 100,
        children: [
          for (var x in [
            1,
            2,
            3,
            4,
            5,
            5,
            6,
            7,
            7,
            8,
            8,
            9,
            9,
          ])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.teal,
                alignment: Alignment.center,
                child: const Text(
                  "Pick me",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
