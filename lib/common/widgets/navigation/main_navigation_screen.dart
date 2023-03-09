import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/features/discover/discover_screen.dart';
import 'package:flutter_ticktoc/features/inbox/inbox_screen.dart';
import 'package:flutter_ticktoc/features/user/user_profile_screen.dart';
import 'package:flutter_ticktoc/features/videos/video_recoding_screen.dart';
import 'package:flutter_ticktoc/features/videos/video_timeline_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'widgets/nav_tap.dart';
import 'widgets/post_video_button.dart';

enum NavigationTab {
  home,
  discover,
  inbox,
  profile;

  static String get allTaps =>
      NavigationTab.values.map((e) => e.name).join("|");
}

extension NavigationTapsX on String {
  String get sentenceCase => replaceFirst(this[0], this[0].toUpperCase());
  NavigationTab get getNavigationTab =>
      NavigationTab.values.byName(toLowerCase());
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, required this.tab});
  static const String routeName = "mainNavigation";
  final NavigationTab tab;
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late NavigationTab _selectedTab = widget.tab;
  void _onTap(NavigationTab tab) {
    context.go("/${tab.name}");
    setState(() {
      _selectedTab = tab;
    });
  }

  void _onPostVideoButtonTap() =>
      context.pushNamed(VideoRecodingScreen.routeName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedTab == NavigationTab.home ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedTab != NavigationTab.home,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedTab != NavigationTab.discover,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedTab != NavigationTab.inbox,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedTab != NavigationTab.profile,
            child: const UserProfileScreen(),
          ),
          const Offstage(
            offstage: true,
            child: Center(
              child: Text("Settings"),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 120,
        color: _selectedTab.index == 0 ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavTap(
              text: NavigationTab.home.name.sentenceCase,
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              isSelected: _selectedTab == NavigationTab.home,
              selectedIndex: _selectedTab.index,
              onTap: () => _onTap(NavigationTab.home),
            ),
            NavTap(
              text: NavigationTab.discover.name.sentenceCase,
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              isSelected: _selectedTab == NavigationTab.discover,
              selectedIndex: _selectedTab.index,
              onTap: () => _onTap(NavigationTab.discover),
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: PostVideoButton(
                inverted: _selectedTab != NavigationTab.home,
              ),
            ),
            Gaps.h24,
            NavTap(
              text: NavigationTab.inbox.name.sentenceCase,
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              isSelected: _selectedTab == NavigationTab.inbox,
              selectedIndex: _selectedTab.index,
              onTap: () => _onTap(NavigationTab.inbox),
            ),
            NavTap(
              text: NavigationTab.profile.name.sentenceCase,
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              isSelected: _selectedTab == NavigationTab.profile,
              selectedIndex: _selectedTab.index,
              onTap: () => _onTap(NavigationTab.profile),
            ),
          ],
        ),
      ),
    );
  }
}
