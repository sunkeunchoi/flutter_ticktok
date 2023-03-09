import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: Colors.white,
          size: Sizes.size40,
        ),
        Gaps.v05,
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
