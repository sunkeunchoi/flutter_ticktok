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
    return SafeArea(
      child: CustomScrollView(
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
          SliverPersistentHeader(
            delegate: CustomDelegate(),
            pinned: true,
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
      ),
    );
  }
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            "Title!!!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
