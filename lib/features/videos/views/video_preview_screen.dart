import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/features/videos/views/widgets/default_loading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  static String routeName = "/video_preview";
  static String routePath = "/video_preview";
  static Route route({
    required XFile video,
    required bool isFromGallery,
  }) =>
      MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(
                video: video,
                isFromGallery: isFromGallery,
              ));
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isFromGallery,
  });
  final XFile video;
  final bool isFromGallery;
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

  bool _savedVideo = false;
  Future<void> _saveToGallery() async {
    if (_savedVideo) return;
    await GallerySaver.saveVideo(widget.video.path, albumName: "TikTok Clone");
    setState(() {
      _savedVideo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Preview',
        ),
        actions: [
          if (!widget.isFromGallery)
            IconButton(
              onPressed: _saveToGallery,
              icon: Icon(
                _savedVideo ? Icons.check_circle_rounded : Icons.save_rounded,
              ),
            ),
        ],
      ),
      body: !_videoPlayerController.value.isInitialized
          ? const DefaultLoading(message: "Preparing video")
          : VideoPlayer(_videoPlayerController),
    );
  }
}
