import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

import 'view_models/sign_up_view_model.dart';
import 'widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});
  static Route route() =>
      MaterialPageRoute(builder: (context) => const BirthdayScreen());
  @override
  BirthdayScreenState createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime _date = DateTime.now().subtract(const Duration(days: 365 * 40));

  @override
  void initState() {
    super.initState();
    _birthdayController.value = TextEditingValue(text: _getDateString());
  }

  String _getDateString() => _date.toIso8601String().split("T").first;
  String _getTimeString() =>
      _date.toIso8601String().split("T").last.substring(0, 5);

  void _setTextFieldDate(DateTime value) {
    setState(() {
      _date = value;
      _birthdayController.value = TextEditingValue(text: _getDateString());
    });
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    ref.read(signUpProvider.notifier).signUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 300,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _date,
          // maximumDate: ,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When is your birthday?",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v08,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _birthdayController,
              enabled: false,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
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
            FormButton(
              disabled: ref.watch(signUpProvider).isLoading,
              text: "Next",
              onTap: _onNextTap,
            ),
          ],
        ),
      ),
    );
  }
}
