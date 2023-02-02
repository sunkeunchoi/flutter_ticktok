import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onTapClosed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Sizes.size20,
          ),
          topRight: Radius.circular(
            Sizes.size20,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            '22796 comments',
          ),
          actions: [
            IconButton(
              onPressed: _onTapClosed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            child: Text("$index"),
          ),
        ),
      ),
    );
  }
}
