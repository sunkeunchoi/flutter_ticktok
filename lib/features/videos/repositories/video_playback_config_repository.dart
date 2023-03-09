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
  Future<bool> getMuted() async => _preferences.getBool(_muted) ?? false;
  Future<bool> getAutoPlay() async => _preferences.getBool(_autoPlay) ?? false;
}
