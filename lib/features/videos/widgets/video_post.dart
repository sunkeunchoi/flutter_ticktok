// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/sizes.dart';
import 'video_button.dart';

class VideoPost extends StatefulWidget {
  final VoidCallback onVideoFinished;
  final int index;
  final String description;
  final bool _hasMore;
  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
    required this.description,
  })  : _hasMore = description.length > 10,
        super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/IMG_1050.MOV");
  bool _isPaused = false;
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
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _seeMore = !widget._hasMore;
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 2.5,
      value: 2.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
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
                  ? VideoPlayer(_videoPlayerController)
                  : Container(color: Colors.black),
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
              bottom: Sizes.size32,
              left: Sizes.size32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "@니꼬",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      Text(
                        widget._hasMore && !_seeMore
                            ? "${widget.description.substring(0, 15)}..."
                            : widget.description,
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                      if (widget._hasMore && !_seeMore) Gaps.h05,
                      if (widget._hasMore && !_seeMore)
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
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/639005?v=4"),
                    child: Text(
                      "니꼬",
                    ),
                  ),
                  Gaps.v20,
                  VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "2.9M",
                  ),
                  Gaps.v20,
                  VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                  Gaps.v20,
                  VideoButton(
                    icon: FontAwesomeIcons.share,
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
