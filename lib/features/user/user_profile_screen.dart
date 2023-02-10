import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          // stretch: true,
          // pinned: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 100,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            // stretchModes: const [
            //   StretchMode.blurBackground,
            //   StretchMode.fadeTitle,
            //   StretchMode.zoomBackground,
            // ],
            background: Image.asset(
              ExampleImage.example1,
              fit: BoxFit.cover,
            ),
            title: const Text("Hello"),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 21,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.red[100 * (index % 7)],
              child: Text(
                "Item $index",
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: 60,
            (context, index) => Container(
              alignment: Alignment.center,
              color: Colors.deepPurple[100 * (index % 7)],
              child: Text(
                "Item $index",
              ),
            ),
          ),
        )
      ],
    );
  }
}
