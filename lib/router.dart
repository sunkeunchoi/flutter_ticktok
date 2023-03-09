import 'package:flutter_ticktoc/common/widgets/navigation/main_navigation_screen.dart';
import 'package:flutter_ticktoc/features/authentication/login_screen.dart';
import 'package:flutter_ticktoc/features/inbox/activity_screen.dart';
import 'package:flutter_ticktoc/features/inbox/chat_detail_screen.dart';
import 'package:flutter_ticktoc/features/inbox/chats_screen.dart';
import 'package:flutter_ticktoc/features/onboarding/interests_screen.dart';
import 'package:flutter_ticktoc/features/videos/video_recoding_screen.dart';
import 'package:go_router/go_router.dart';

import 'features/authentication/signup_screen.dart';

final router = GoRouter(
  initialLocation: "/inbox",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: "/:tab(${NavigationTab.allTaps})",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(
          tab: tab.getNavigationTab,
        );
      },
    ),
    GoRoute(
      path: ActivityScreen.routeURL,
      name: ActivityScreen.routeName,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      path: ChatsScreen.routeURL,
      name: ChatsScreen.routeName,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          path: ChatDetailScreen.routeURL,
          name: ChatDetailScreen.routeName,
          builder: (context, state) {
            final chatId = state.params['chatId']!;
            return ChatDetailScreen(chatId: chatId);
          },
        )
      ],
    ),
    GoRoute(
      path: VideoRecodingScreen.routePath,
      name: VideoRecodingScreen.routeName,
      builder: (context, state) => const VideoRecodingScreen(),
    )
  ],
);
