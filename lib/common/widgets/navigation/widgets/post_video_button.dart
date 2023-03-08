import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostVideoButton extends StatelessWidget {
  final bool inverted;
  const PostVideoButton({
    super.key,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 20,
          child: Container(
            height: 35,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size08,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF61D4F0),
              borderRadius: BorderRadius.circular(
                Sizes.size08,
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            height: 35,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size08,
              ),
            ),
          ),
        ),
        Container(
          height: 35,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: inverted ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(
              Sizes.size06,
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted ? Colors.white : Colors.black,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
