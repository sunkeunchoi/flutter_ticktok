import 'package:flutter_ticktoc/features/authentication/login_screen.dart';
import 'package:flutter_ticktoc/features/onboarding/interests_screen.dart';
import 'package:go_router/go_router.dart';

import 'features/authentication/signup_screen.dart';

final router = GoRouter(
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
  ],
);
