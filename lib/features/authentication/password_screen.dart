import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/birthday_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toogleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "Password",
                style: textStyle.titleLarge,
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                autocorrect: false,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onClearTap,
                          child: Icon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.5),
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: _toogleObscureText,
                          child: Icon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    hintText: "Make it strong!",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    )),
              ),
              Gaps.v16,
              Text(
                "Your password must have:",
                style: textStyle.labelLarge,
              ),
              Gaps.v10,
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.circleCheck,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h10,
                  const Text(
                    "8 to 20 characters",
                  ),
                ],
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h10,
                  const Text("Letters, numbers, and special characters"),
                ],
              ),
              Gaps.v28,
              FormButton(
                disabled: !_isPasswordValid(),
                text: "Next",
                onTap: _onSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
