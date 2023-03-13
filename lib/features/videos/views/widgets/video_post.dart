// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/assets/video.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/videos/view_models/playback_config_vm.dart';
import 'package:flutter_ticktoc/features/videos/views/widgets/video_comments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/video_model.dart';
import 'video_button.dart';

class VideoPost extends ConsumerStatefulWidget {
  final VoidCallback onVideoFinished;
  final int index;
  final VideoModel videoData;
  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  }) : super(key: key);

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset(ExampleVideo.example1);
  bool _isPaused = false;
  late final bool _hasMore = widget.videoData.description.length > 20;
  late bool _seeMore;
  final _animationDuration = const Duration(milliseconds: 200);

  bool _isFinished() {
    return _videoPlayerController.value.isInitialized &&
        _videoPlayerController.value.duration ==
            _videoPlayerController.value.position;
  }

  void _onVideoChange() {
    if (_isFinished()) widget.onVideoFinished();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    // _videoPlayerController.play();
    setState(() {});
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) await _videoPlayerController.setVolume(0);
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _seeMore = _hasMore;
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 2.5,
      value: 2.5,
      duration: _animationDuration,
    );
    _initMuted();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMuted() {
    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);
    if (!muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _initMuted() {
    final muted = ref.read(playbackConfigProvider).muted;
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      }
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapSeeMore() {
    setState(() {
      _seeMore = !_seeMore;
    });
  }

  void _onTapComments(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      barrierColor: Colors.black.withOpacity(0.5),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 50,
      edgeOffset: 20,
      color: Theme.of(context).primaryColor,
      child: VisibilityDetector(
        key: Key("${widget.index}"),
        onVisibilityChanged: _onVisibilityChanged,
        child: Stack(
          children: [
            Positioned.fill(
              child: _videoPlayerController.value.isInitialized
                  // https://stackoverflow.com/questions/57077639/how-to-boxfit-cover-a-fullscreen-videoplayer-widget-with-specific-aspect-ratio
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoPlayerController.value.aspectRatio,
                        height: 1,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    )
                  : Image.network(
                      widget.videoData.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: _onTogglePause,
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animationController.value,
                        child: child,
                      );
                    },
                    child: AnimatedOpacity(
                      opacity: _isPaused ? 1 : 0,
                      duration: _animationDuration,
                      child: const FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                        size: Sizes.size64,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 48,
              left: 24,
              child: IconButton(
                onPressed: _toggleMuted,
                icon: Icon(
                  ref.watch(playbackConfigProvider).muted
                      ? Icons.volume_off
                      : Icons.volume_up_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: Sizes.size32,
              left: Sizes.size32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "@${widget.videoData.creator}",
                    style: const TextStyle(
                      fontSize: Sizes.size20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      Text(
                        _hasMore && !_seeMore
                            ? "${widget.videoData.description.substring(0, 15)}..."
                            : widget.videoData.description,
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                      if (_hasMore && !_seeMore) Gaps.h05,
                      if (_hasMore && !_seeMore)
                        GestureDetector(
                          onTap: _onTapSeeMore,
                          child: const Text(
                            "See More",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.white,
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: Sizes.size12,
              right: Sizes.size12,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tiktok-aroxima.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media",
                    ),
                    child: Text(
                      "@${widget.videoData.creator}",
                    ),
                  ),
                  Gaps.v20,
                  VideoButton(
                    icon: Icons.favorite,
                    text: "${widget.videoData.likes}",
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: () => _onTapComments(context),
                    child: VideoButton(
                      icon: Icons.comment,
                      text: "${widget.videoData.comments}",
                    ),
                  ),
                  Gaps.v20,
                  const VideoButton(
                    icon: Icons.share,
                    text: "Share",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
