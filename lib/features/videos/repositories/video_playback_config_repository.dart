import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  final SharedPreferences _preferences;
  static const _autoPlay = "autoPlay";
  static const _muted = "muted";
  VideoPlaybackConfigRepository(this._preferences);
  Future<void> setMuted(bool value) async =>
      _preferences.setBool(_muted, value);

  Future<void> setAutoPlay(bool value) async =>
      _preferences.setBool(_autoPlay, value);
  bool get getMuted => _preferences.getBool(_muted) ?? false;
  bool get getAutoPlay => _preferences.getBool(_autoPlay) ?? false;
}
