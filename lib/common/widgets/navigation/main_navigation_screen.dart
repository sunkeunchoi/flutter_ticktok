import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/features/discover/discover_screen.dart';
import 'package:flutter_ticktoc/features/inbox/inbox_screen.dart';
import 'package:flutter_ticktoc/features/user/user_profile_screen.dart';
import 'package:flutter_ticktoc/features/videos/video_recoding_screen.dart';
import 'package:flutter_ticktoc/features/videos/video_timeline_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/nav_tap.dart';
import 'widgets/post_video_button.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(VideoRecodingScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const Center(
              child: Text("Settings"),
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 120,
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavTap(
              text: "Home",
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              isSelected: _selectedIndex == 0,
              selectedIndex: _selectedIndex,
              onTap: () => _onTap(0),
            ),
            NavTap(
              text: "Discover",
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              isSelected: _selectedIndex == 1,
              selectedIndex: _selectedIndex,
              onTap: () => _onTap(1),
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: PostVideoButton(
                inverted: _selectedIndex != 0,
              ),
            ),
            Gaps.h24,
            NavTap(
              text: "Inbox",
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              isSelected: _selectedIndex == 3,
              selectedIndex: _selectedIndex,
              onTap: () => _onTap(3),
            ),
            NavTap(
              text: "Profile",
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              isSelected: _selectedIndex == 4,
              selectedIndex: _selectedIndex,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
