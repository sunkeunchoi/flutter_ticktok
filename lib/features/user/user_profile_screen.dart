import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.teal,
          collapsedHeight: 100,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              ExampleImage.example1,
              fit: BoxFit.cover,
            ),
            title: const Text("Hello"),
          ),
        ),
      ],
    );
  }
}
