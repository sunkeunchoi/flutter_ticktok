import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/features/videos/widgets/default_loading.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  static String routeName = "/video_preview";
  static String routePath = "/video_preview";
  static Route route(XFile video) =>
      MaterialPageRoute(builder: (context) => VideoPreviewScreen(video: video));
  const VideoPreviewScreen({
    super.key,
    required this.video,
  });
  final XFile video;

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  Future<void> initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Preview',
        ),
      ),
      body: !_videoPlayerController.value.isInitialized
          ? const DefaultLoading(message: "Preparing video")
          : VideoPlayer(_videoPlayerController),
    );
  }
}
