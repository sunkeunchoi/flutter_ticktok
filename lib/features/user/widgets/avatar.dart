import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/user/view_models/avatar_view_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/sizes.dart';

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });
  final String name;
  final bool hasAvatar;
  final String uid;
  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(avatarProvider).when(
          data: (data) => GestureDetector(
            onTap: () => _onAvatarTap(ref),
            child: CircleAvatar(
              radius: Sizes.size52,
              foregroundColor: Colors.teal,
              foregroundImage: hasAvatar
                  ? NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tiktok-aroxima.appspot.com/o/avatars%2F$uid?alt=media")
                  : null,
              child: Text(name),
            ),
          ),
          loading: () => Container(
            width: Sizes.size52,
            height: Sizes.size52,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => SizedBox(
            height: Sizes.size52,
            child: Text(error.toString()),
          ),
        );
  }
}
