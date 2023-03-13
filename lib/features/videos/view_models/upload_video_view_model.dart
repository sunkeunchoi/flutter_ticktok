import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';

import '../repositories/video_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideoRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepository);
  }

  Future<void> uploadVideo(File video) async {
    final uid = ref.read(authRepository).uid!;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(video, uid);
      if (task.metadata != null) {
        await _repository.saveVideo();
      }
    });
  }
}
