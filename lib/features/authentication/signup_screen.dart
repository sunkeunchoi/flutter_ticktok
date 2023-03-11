import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/username_screen.dart';
import 'package:flutter_ticktoc/features/authentication/login_screen.dart';
import 'package:flutter_ticktoc/features/authentication/widgets/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'view_models/social_auth_view_model.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeName = "signUp";
  static const String routeURL = "/";
  static Route route() => MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) =>
      context.pushNamed(LoginScreen.routeName);

  void onEmailTap(BuildContext context) =>
      Navigator.push(context, UsernameScreen.route());

  void onSignupTap(BuildContext context) =>
      Navigator.push(context, UsernameScreen.route());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                const Text(
                  "Sign up for TikTok",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                const Text(
                  "Create a profile, follow other other accounts, make your own videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
                  AuthButton(
                    text: "Use email & password",
                    icon: const FaIcon(
                      FontAwesomeIcons.user,
                    ),
                    onTapCallback: () => onEmailTap(context),
                  ),
                  Gaps.v16,
                  AuthButton(
                    text: "Continue with Github",
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                    ),
                    onTapCallback: () => ref
                        .read(socialAuthProvider.notifier)
                        .githubSignIn(context),
                  ),
                ],
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                          text: "Use email & password",
                          icon: const FaIcon(
                            FontAwesomeIcons.user,
                          ),
                          onTapCallback: () => onEmailTap(context),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          text: "Continue with Apple",
                          icon: const FaIcon(
                            FontAwesomeIcons.apple,
                          ),
                          onTapCallback: () {},
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
              ),
              Gaps.h05,
              GestureDetector(
                onTap: () => onLoginTap(context),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
