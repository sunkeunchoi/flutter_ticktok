import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          title: const Text("니꼬"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: Sizes.size52,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(ExampleImage.profile1),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@니꼬",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.h05,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size20,
                    color: Colors.blue.shade500,
                  ),
                ],
              ),
              Gaps.v20,
              SizedBox(
                height: Sizes.size52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    UserCount(
                      counts: "37",
                      title: "Following",
                    ),
                    Divider(),
                    UserCount(
                      counts: "10M",
                      title: "Followers",
                    ),
                    Divider(),
                    UserCount(
                      counts: "194.3M",
                      title: "Likes",
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: Sizes.size32,
      thickness: Sizes.size02,
      color: Colors.grey.shade400,
      indent: Sizes.size14,
      endIndent: Sizes.size14,
    );
  }
}

class UserCount extends StatelessWidget {
  final String title;
  final String counts;
  const UserCount({
    super.key,
    required this.title,
    required this.counts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          counts,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size20,
          ),
        ),
        Gaps.v05,
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
