import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/common/IconImageProvider.dart';
import 'package:flutter_ticktoc/common/widgets/video_configuration/video_configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  List<bool> isSelected = [true, false];
  bool forImage = false;
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
          AnimatedBuilder(
            animation: videoConfig,
            builder: (context, child) => SwitchListTile.adaptive(
              title: const Text("Auto mute enabled"),
              subtitle: const Text("Videos will be muted by default"),
              value: videoConfig.autoMute,
              onChanged: (value) => videoConfig.toggleAutoMute(),
            ),
          ),
          CheckboxListTile(value: false, onChanged: (value) {}),
          RadioListTile(
            value: false,
            groupValue: null,
            onChanged: (value) {},
          ),
          Switch(
            value: forImage,
            onChanged: (value) => setState(() {
              forImage = value;
            }),
            activeThumbImage: IconImageProvider(
              Icons.volume_off,
            ),
            activeColor: Colors.red,
            inactiveThumbImage: IconImageProvider(Icons.volume_up),
            inactiveThumbColor: Colors.blue,
          ),
          ToggleButtons(
            isSelected: isSelected,
            children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
            onPressed: (newIndex) => setState(() {
              isSelected = List<bool>.generate(
                  isSelected.length, (index) => index == newIndex,
                  growable: false);
            }),
          ),
          ListTile(
            title: const Text("iOS bottom sheet"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  message: const Text("Please don't go"),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                      ),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text(
                        "Yes",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Please dont't go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text(
                        "Yes",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (android)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(
                    FontAwesomeIcons.skull,
                  ),
                  title: const Text("Are you sure?"),
                  content: const Text("Please dont't go"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(
                        FontAwesomeIcons.car,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(
                        FontAwesomeIcons.a,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
