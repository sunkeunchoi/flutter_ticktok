import 'package:flutter/cupertino.dart';

class VideoConfigurationData extends InheritedWidget {
  final bool autoMute;
  final VoidCallback toggleMuted;
  const VideoConfigurationData({
    required this.toggleMuted,
    super.key,
    required super.child,
    required this.autoMute,
  });

  static VideoConfigurationData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VideoConfigurationData>()!;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfiguration extends StatefulWidget {
  final Widget child;

  const VideoConfiguration({super.key, required this.child});

  @override
  State<VideoConfiguration> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfiguration> {
  bool autoMute = true;
  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigurationData(
      autoMute: autoMute,
      toggleMuted: toggleMuted,
      child: widget.child,
    );
  }
}
