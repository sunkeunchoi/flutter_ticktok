import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All activity',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        children: [
          Text(
            "New",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade500,
            ),
          ),
          Gaps.v14,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: Sizes.size52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ),
              ),
            ),
            title: RichText(
              text: const TextSpan(
                text: "Account updates:",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
