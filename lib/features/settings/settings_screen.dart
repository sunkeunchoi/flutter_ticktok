import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifiactions = false;
  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifiactions = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: ListView(
        children: [
          const AboutListTile(),
          SwitchListTile.adaptive(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          SwitchListTile(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          Switch.adaptive(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          CupertinoSwitch(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          Switch(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          Checkbox(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
          ),
          CheckboxListTile(
            value: _notifiactions,
            onChanged: _onNotificationsChanged,
            activeColor: Colors.black,
            title: const Text(
              "Enable notifications",
            ),
          ),
        ],
      ),
    );
  }
}
