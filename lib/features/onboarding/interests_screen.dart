import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

import 'tutorial_screen.dart';
import 'widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learing",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    var current = _scrollController.offset > 100;
    if (_showTitle && current) return;
    setState(() {
      _showTitle = current;
    });
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(
            microseconds: 300,
          ),
          child: const Text(
            'Choose your interests',
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        elevation: 2,
        child: GestureDetector(
          onTap: _onNextTap,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size05,
              ),
            ),
            child: Text(
              "Next",
              style: textStyle.bodyLarge!.copyWith(
                color: isDark ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: Sizes.size24,
                right: Sizes.size24,
                bottom: Sizes.size24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose your interests",
                    style: textStyle.headlineLarge,
                  ),
                  Gaps.v20,
                  Text(
                    "Get better video recommendations",
                    style: textStyle.titleLarge,
                  ),
                  Gaps.v64,
                  Wrap(
                    runSpacing: Sizes.size10,
                    spacing: Sizes.size10,
                    children: [
                      for (var interest in interests)
                        InterestButton(interest: interest)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
