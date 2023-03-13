import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/videos/repositories/video_repository.dart';

import '../models/video_model.dart';

export '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepository _repository;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepository);
    _list = await _fetchVideos();
    return _list;
  }

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
    return result.docs
        .map(
          (e) => VideoModel.fromMap(e.data()),
        )
        .toList();
  }

  Future<void> fetchNextPage() async {
    final newList = await _fetchVideos(
      lastItemCreatedAt: _list.last.createdAt,
    );

    _list = [..._list, ...newList];
    state = AsyncValue.data(_list);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
