import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/username_screen.dart';
import 'package:flutter_ticktoc/features/authentication/login_screen.dart';
import 'package:flutter_ticktoc/features/authentication/widgets/auth_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void onEmailTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UsernameScreen()));
  }

  void onSignupTap(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const UsernameScreen()));

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
            child: Column(
              children: [
                Gaps.v80,
                Text(
                  "Sign up for TikTok",
                  style: textStyle.headlineLarge,
                ),
                Gaps.v20,
                Text(
                  "Create a profile, follow other other accounts, make your own videos, and more.",
                  style: textStyle.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Gaps.v40,
                if (orientation == Orientation.portrait) ...[
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
                if (orientation == Orientation.landscape)
                  Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                          text: "Use email & password",
                          icon: const Icon(
                            FontAwesomeIcons.user,
                          ),
                          onTapCallback: () => onEmailTap(context),
                        ),
                      ),
                      Gaps.h16,
                      Expanded(
                        child: AuthButton(
                          text: "Continue with Apple",
                          icon: const Icon(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: textStyle.bodyLarge,
              ),
              Gaps.h05,
              GestureDetector(
                onTap: () => onLoginTap(context),
                child: Text(
                  "Login",
                  style: textStyle.bodyLarge!.copyWith(
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
