import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/login_form_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  static const String routeURL = "/login";
  const LoginScreen({super.key});
  void onSinupTap(BuildContext context) => Navigator.of(context).pop();

  void onEmailTap(BuildContext context) =>
      Navigator.push(context, LoginFormScreen.route());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Login to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                text: "Use email & password",
                icon: const FaIcon(
                  FontAwesomeIcons.user,
                ),
                onTapCallback: () => onEmailTap(context),
              ),
              Gaps.v16,
              AuthButton(
                text: "Continue with Apple",
                icon: const FaIcon(
                  FontAwesomeIcons.apple,
                ),
                onTapCallback: () {},
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
              "Dont' have an account?",
            ),
            Gaps.h05,
            GestureDetector(
              onTap: () => onSinupTap(context),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
