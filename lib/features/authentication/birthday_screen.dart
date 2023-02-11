import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/onboarding/interests_screen.dart';

import 'widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      bottomNavigationBar: BottomAppBar(
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
            Text(
              "When is your birthday?",
              style: textStyle.titleLarge,
            ),
            Gaps.v08,
            Text(
              "Your birthday won't be shown publicly.",
              style: textStyle.bodyLarge,
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
                ),
              ),
            ),
            Gaps.v16,
            FormButton(
              disabled: false,
              text: "Next",
              onTap: _onNextTap,
            ),
          ],
        ),
      ),
    );
  }
}
