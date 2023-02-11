import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/login_form_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  void onSinupTap(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginFormScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Login to TikTok",
                style: textStyle.headlineLarge,
              ),
              Gaps.v20,
              Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: textStyle.titleMedium,
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                text: "Use email & password",
                icon: const Icon(
                  FontAwesomeIcons.user,
                ),
                onTapCallback: () => onEmailTap(context),
              ),
              Gaps.v16,
              AuthButton(
                text: "Continue with Apple",
                icon: const Icon(
                  FontAwesomeIcons.apple,
                ),
                onTapCallback: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dont' have an account?",
              style: textStyle.bodyLarge,
            ),
            Gaps.h05,
            GestureDetector(
              onTap: () => onSinupTap(context),
              child: Text(
                "Sign up",
                style: textStyle.bodyLarge!.copyWith(
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
