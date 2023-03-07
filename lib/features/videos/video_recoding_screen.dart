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

class _VideoRecodingScreenState extends State<VideoRecodingScreen> {
  late final CameraController _cameraController;
  bool _hasPermission = false;
  bool _isReady = false;
  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _cameraController =
        CameraController(cameras.first, ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
    setState(() {
      _isReady = _hasPermission && _cameraController.value.isInitialized;
    });
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

  @override
  void initState() {
    super.initState();
    initPermissions();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VideoRecodingScreen',
        ),
      ),
      body: _isReady
          ? const DefaultLoading(message: "Requesting permissions")
          : Stack(
              alignment: Alignment.center,
              children: [
                CameraPreview(_cameraController),
              ],
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
