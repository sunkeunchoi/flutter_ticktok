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
                    text: "Continue with Apple",
                    icon: const FaIcon(
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
