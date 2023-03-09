import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/videos/repositories/video_playback_config_repository.dart';
import 'package:flutter_ticktoc/features/videos/views/models/playback_config_model.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(value) {
    _repository.setAutoPlay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  void toggleMuted() => setMuted(!state.muted);
  void toggleAutoPlay() => setAutoPlay(!state.autoPlay);

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.getMuted,
      autoPlay: _repository.getAutoPlay,
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
