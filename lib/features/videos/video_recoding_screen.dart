// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
    with TickerProviderStateMixin {
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
    _flashMode = _cameraController.value.flashMode;
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
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

  void _startRecording(TapDownDetails details) {
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  void _stopRecording() {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    print(_progressAnimationController.value);
    return Scaffold(
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? const DefaultLoading(message: "Requesting permissions")
          : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    bottom: 48,
                    child: GestureDetector(
                      onTapDown: _startRecording,
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
            ),
    );
  }
}

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: textTheme.titleLarge,
          ),
          const Divider(color: Colors.transparent),
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
