import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/videos/repositories/video_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepository _repository;
  late final _videoId;
  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videoRepository);
  }

  Future<void> toggleVideoLike(String videoId) async {
    final userId = ref.read(authRepository).uid;
    await _repository.toggleVideoLike(
      videoId: videoId,
      userId: userId!,
    );
  }

  Future<bool> isLikedVideo(String videoId) async {
    final userId = ref.read(authRepository).uid;
    return await _repository.isLikedVideo(
      videoId: videoId,
      userId: userId!,
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
