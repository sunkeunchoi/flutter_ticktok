import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 6;
  List<Color> colors = [
    Colors.lightBlue,
    Colors.yellow,
    Colors.red,
    Colors.teal,
    Colors.purple,
    Colors.lightGreen
  ];
  void _onPageChanged(int page) {
    if (page < _itemCount - 2) return;
    setState(() {
      colors.addAll([
        Colors.lightBlue,
        Colors.yellow,
        Colors.red,
        Colors.teal,
        Colors.purple,
        Colors.lightGreen
      ]);
      _itemCount = _itemCount + 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: colors.length,
      onPageChanged: _onPageChanged,
      // pageSnapping: false,
      itemBuilder: (context, index) => Container(
          color: colors.elementAt(
            index,
          ),
          child: Center(
            child: Text("Screen $index",
                style: const TextStyle(
                  fontSize: Sizes.size60,
                )),
          )),
    );
  }
}
