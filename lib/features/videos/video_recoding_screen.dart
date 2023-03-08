// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/features/videos/video_preview_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/default_loading.dart';

class VideoRecodingScreen extends StatefulWidget {
  static String routeName = "/video_recoding";
  static String routePath = "/video_recoding";
  static Route route() =>
      MaterialPageRoute(builder: (context) => const VideoRecodingScreen());
  const VideoRecodingScreen({super.key});

  @override
  State<VideoRecodingScreen> createState() => _VideoRecodingScreenState();
}

class _VideoRecodingScreenState extends State<VideoRecodingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late CameraController _cameraController;
  bool _hasPermission = false;
  bool _isSelfieMode = true;
  late FlashMode _flashMode;
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final Animation<double> _buttonAnimation =
      Tween<double>(begin: 1.0, end: 1.2).animate(_buttonAnimationController);
  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty || cameras.length < 2) return;
    _cameraController = CameraController(
      _isSelfieMode ? cameras[1] : cameras[0],
      ResolutionPreset.max,
    );
    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    _flashMode = _cameraController.value.flashMode;
    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final microphoneDenied = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;
    if (!cameraDenied && !microphoneDenied) {
      setState(() {
        _hasPermission = true;
      });
    } else {}
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    setState(() {
      _flashMode = newFlashMode;
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPermissions();
    initCamera();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    log(state.toString());
    switch (state) {
      case AppLifecycleState.resumed:
        if (_cameraController.value.isInitialized) break;
        await initCamera();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (!_cameraController.value.isInitialized) break;
        _cameraController.dispose();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> _startRecording() async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    if (!_cameraController.value.isRecordingVideo) return;
    final video = await _cameraController.stopVideoRecording();
    if (!mounted) return;
    Navigator.of(context).push(VideoPreviewScreen.route(
      video: video,
      isFromGallery: false,
    ));
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;
    if (!mounted) return;
    Navigator.of(context).push(VideoPreviewScreen.route(
      video: video,
      isFromGallery: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? const DefaultLoading(message: "Requesting permissions")
          : Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_cameraController),
                Positioned(
                  bottom: 48,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTapDown: (_) => _startRecording(),
                        onTapUp: (_) => _stopRecording(),
                        onLongPressEnd: (_) => _stopRecording(),
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 96,
                                height: 96,
                                child: CircularProgressIndicator(
                                  color: Colors.redAccent,
                                  strokeWidth: 6,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: 84,
                                height: 84,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            iconSize: 42,
                            color: Colors.white,
                            padding: const EdgeInsets.all(12),
                            icon: const Icon(Icons.image_outlined),
                            onPressed: _onPickVideoPressed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 24,
                  right: 24,
                  child: Column(
                    children: [
                      const Divider(color: Colors.transparent),
                      GestureDetector(
                        onTap: _toggleSelfieMode,
                        child: const Icon(
                          Icons.cameraswitch_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      GestureDetector(
                        onTap: () => _setFlashMode(FlashMode.off),
                        child: Icon(
                          Icons.flash_off_rounded,
                          size: 36,
                          color: _flashMode == FlashMode.off
                              ? Colors.amberAccent
                              : Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      GestureDetector(
                        onTap: () => _setFlashMode(FlashMode.always),
                        child: Icon(
                          Icons.flash_on_rounded,
                          size: 36,
                          color: _flashMode == FlashMode.always
                              ? Colors.amberAccent
                              : Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      GestureDetector(
                        onTap: () => _setFlashMode(FlashMode.auto),
                        child: Icon(
                          Icons.flash_auto_rounded,
                          size: 36,
                          color: _flashMode == FlashMode.auto
                              ? Colors.amberAccent
                              : Colors.white,
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      GestureDetector(
                        onTap: () => _setFlashMode(FlashMode.torch),
                        child: Icon(
                          Icons.flashlight_on_rounded,
                          size: 36,
                          color: _flashMode == FlashMode.torch
                              ? Colors.amberAccent
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
