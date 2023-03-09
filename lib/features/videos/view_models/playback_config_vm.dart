import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/features/videos/repositories/video_playback_config_repository.dart';
import 'package:flutter_ticktoc/features/videos/views/models/playback_config_model.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);
  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.getMuted,
    autoPlay: _repository.getAutoPlay,
  );
  void setMuted(value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoPlay(value) {
    _repository.setAutoPlay(value);
    _model.autoPlay = value;
    notifyListeners();
  }

  void toggleMuted() => setMuted(!_model.muted);
  void toggleAutoPlay() => setAutoPlay(!_model.autoPlay);
  bool get isMuted => _model.muted;
  bool get isAutoPlay => _model.autoPlay;
}
