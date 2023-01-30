import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

enum Direction { right, left }

enum Pages { first, second }

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Pages _showingPage = Pages.first;

  void _onPanUpdate(DragUpdateDetails details) {
    var current = details.delta.dx > 0 ? Direction.right : Direction.left;
    if (current == _direction) return;
    setState(() {
      _direction = current;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _showingPage = _direction == Direction.left ? Pages.second : Pages.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: AnimatedCrossFade(
              crossFadeState: _showingPage == Pages.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(microseconds: 3000),
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v52,
                  Text(
                    "Follow the rules!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Take care plis!",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 140,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
              vertical: Sizes.size10,
            ),
            child: AnimatedOpacity(
              duration: const Duration(
                microseconds: 300,
              ),
              opacity: _showingPage == Pages.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                child: const Text(
                  "Enter the app!",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
