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
  late CameraController _cameraController;
  bool _hasPermission = false;
  bool _isSelfieMode = true;
  Future<void> initCamera() async {
    final cameras = await availableCameras();
    print(cameras);
    if (cameras.isEmpty || cameras.length < 2) return;
    _cameraController = CameraController(
      _isSelfieMode ? cameras[1] : cameras[0],
      ResolutionPreset.max,
    );
    await _cameraController.initialize();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_hasPermission || !_cameraController.value.isInitialized
          ? const DefaultLoading(message: "Requesting permissions")
          : Center(
              child: Stack(
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: 24,
                    right: 24,
                    child: GestureDetector(
                      onTap: _toggleSelfieMode,
                      child: const Icon(
                        Icons.cameraswitch_rounded,
                        size: 36,
                        color: Colors.white,
                      ),
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
