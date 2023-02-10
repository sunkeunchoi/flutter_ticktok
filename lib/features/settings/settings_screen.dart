import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        children: const [
          CupertinoActivityIndicator(),
          CircularProgressIndicator(),
          CloseButton(),
          CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
