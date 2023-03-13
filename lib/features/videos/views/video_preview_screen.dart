import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/videos/models/video_upload.dart';
import 'package:flutter_ticktoc/features/videos/views/widgets/default_loading.dart';
import 'package:flutter_ticktoc/features/videos/views/widgets/video_upload_form.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

import '../view_models/upload_video_view_model.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
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
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
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

  void _onUploadPressed() async {
    _videoPlayerController.pause();
    final data =
        await Navigator.of(context).push<VideoUpload?>(VideoUploadForm.route());
    if (data == null) return;
    if (!mounted) return;
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          video: File(widget.video.path),
          title: data.title,
          description: data.description,
          context: context,
        );
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
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? null
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator.adaptive()
                : const Icon(Icons.cloud_upload_rounded),
          )
        ],
      ),
      body: !_videoPlayerController.value.isInitialized
          ? const DefaultLoading(message: "Preparing video")
          : VideoPlayer(_videoPlayerController),
    );
  }
}
