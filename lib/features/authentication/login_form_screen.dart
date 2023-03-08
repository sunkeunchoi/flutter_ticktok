import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/widgets/form_button.dart';
import 'package:flutter_ticktoc/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});
  static Route route() =>
      MaterialPageRoute(builder: (context) => const LoginFormScreen());
  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) return "Please write your email";
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "Please write your password";
    return null;
  }

  void _sumbitEmail(String? value) {
    if (value == null) return;
    _formData['email'] = value;
  }

  void _submitPassword(String? value) {
    if (value == null) return;
    _formData['password'] = value;
  }

  void _onSubmitTap() {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: _emailValidator,
                  onSaved: _sumbitEmail,
                ),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: _passwordValidator,
                  onSaved: _submitPassword,
                ),
                Gaps.v28,
                FormButton(
                  disabled: false,
                  text: "Login",
                  onTap: _onSubmitTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
