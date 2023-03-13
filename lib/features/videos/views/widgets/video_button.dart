import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
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
