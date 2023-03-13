import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/user/view_models/users_view_model.dart';
import 'package:go_router/go_router.dart';

import '../models/video_model.dart';
import '../repositories/video_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepository);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final uid = ref.read(authRepository).uid!;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(video, uid);
      if (task.metadata != null) {
        await _repository.saveVideo(
          VideoModel(
            title: "From flutter!",
            description: "Hello yeah!",
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: "",
            creatorUid: uid,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().microsecondsSinceEpoch,
            creator: userProfile.name.toString(),
          ),
        );
        context.pushReplacement("/home");
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
