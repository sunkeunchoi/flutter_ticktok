import 'package:flutter/material.dart';

import '../constants/gaps.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: const [
            Gaps.v96,
            Text("Home Screen"),
          ],
        ),
      ),
    );
  }
}
