import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/videos/repositories/video_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideoRepository _repository;
  late final String _videoId;
  late final String _userId;
  bool _isLiked = false;
  @override
  FutureOr<bool> build(String arg) async {
    _userId = ref.read(authRepository).uid!;
    _videoId = arg;
    _repository = ref.read(videoRepository);
    _isLiked =
        await _repository.isLikedVideo(videoId: _videoId, userId: _userId);
    return _isLiked;
  }

  Future<void> toggleVideoLike() async {
    await _repository.toggleVideoLike(
      videoId: _videoId,
      userId: _userId,
    );
    _isLiked = !_isLiked;
    state = AsyncValue.data(_isLiked);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);
