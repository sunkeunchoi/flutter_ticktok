import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/view_models/sign_up_view_model.dart';
import 'package:flutter_ticktoc/features/videos/view_models/playback_config_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: const Text("Mute video"),
            subtitle: const Text("Video will be muted by default."),
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: ref.read(playbackConfigProvider.notifier).setMuted,
          ),
          SwitchListTile.adaptive(
            title: const Text("Auto play"),
            subtitle: const Text("Video will start playing automatically"),
            value: ref.watch(playbackConfigProvider).autoPlay,
            onChanged: ref.read(playbackConfigProvider.notifier).setAutoPlay,
          ),
          CheckboxListTile(value: false, onChanged: (value) {}),
          RadioListTile(
            value: false,
            groupValue: null,
            onChanged: (value) {},
          ),
          // Switch(
          //   value: forImage,
          //   onChanged: (value) => setState(() {
          //     forImage = value;
          //   }),
          //   activeThumbImage: IconImageProvider(
          //     Icons.volume_off,
          //   ),
          //   activeColor: Colors.red,
          //   inactiveThumbImage: IconImageProvider(Icons.volume_up),
          //   inactiveThumbColor: Colors.blue,
          // ),
          // ToggleButtons(
          //   isSelected: isSelected,
          //   children: const [Icon(Icons.dark_mode), Icon(Icons.light_mode)],
          //   onPressed: (newIndex) => setState(() {
          //     isSelected = List<bool>.generate(
          //         isSelected.length, (index) => index == newIndex,
          //         growable: false);
          //   }),
          // ),
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
                  content: const Text("Please don't go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        ref.read(signUpProvider.notifier).signOut();
                        context.go("/");
                      },
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
                  content: const Text("Please don't go"),
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
