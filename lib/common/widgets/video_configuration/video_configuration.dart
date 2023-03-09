import 'package:flutter/cupertino.dart';

class VideoConfiguration extends InheritedWidget {
  const VideoConfiguration({super.key, required super.child});
  final bool autoMute = true;

  static VideoConfiguration of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VideoConfiguration>()!;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
