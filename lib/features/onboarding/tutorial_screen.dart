import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/navigation/main_navigation_screen.dart';

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
  final Duration _duration = const Duration(milliseconds: 500);
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

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainNavigationScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
              duration: _duration,
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v52,
                  Text(
                    "Watch cool videos!",
                    style: textStyle.displayMedium,
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like and share.",
                    style: textStyle.titleLarge,
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v52,
                  Text(
                    "Follow the rules!",
                    style: textStyle.displayMedium,
                  ),
                  Gaps.v16,
                  Text(
                    "Take care plis!",
                    style: textStyle.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
              vertical: Sizes.size10,
            ),
            child: AnimatedOpacity(
              duration: _duration,
              opacity: _showingPage == Pages.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: _onEnterAppTap,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Enter the app!",
                  style: textStyle.titleLarge!.copyWith(
                    color: isDark ? Colors.black : Colors.white,
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
