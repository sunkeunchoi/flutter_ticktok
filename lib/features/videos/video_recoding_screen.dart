import 'package:flutter/material.dart';

class VideoRecodingScreen extends StatelessWidget {
  static String routeName = "/video_recoding";
  static String routePath = "/video_recoding";
  static Route route() =>
      MaterialPageRoute(builder: (context) => const VideoRecodingScreen());
  const VideoRecodingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VideoRecodingScreen',
        ),
      ),
    );
  }
}
