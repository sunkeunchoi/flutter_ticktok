import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Direct messages',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: Sizes.size28,
              foregroundImage: NetworkImage(
                ExampleImage.profile1,
              ),
              child: Text("니꼬"),
            ),
            title: const Text(
              "Lynn",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Don't forget to make video",
            ),
            trailing: Text(
              "2:16 PM",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: Sizes.size12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
