import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/settings/settings_screen.dart';
import 'package:flutter_ticktoc/features/user/view_models/users_view_model.dart';
import 'package:flutter_ticktoc/features/user/widgets/avatar.dart';
import 'package:flutter_ticktoc/features/user/widgets/persistent_tab_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          data: (data) => Scaffold(
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverAppBar(
                            title: Text(data.name.toString()),
                            actions: [
                              IconButton(
                                onPressed: _onGearPressed,
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
                                Avatar(name: data.name.toString()),
                                Gaps.v20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "@${data.name}",
                                      style: const TextStyle(
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
                                ),
                                Gaps.v14,
                                FractionallySizedBox(
                                  widthFactor: 0.33,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size14,
                                      horizontal: Sizes.size10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size05,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: const Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Gaps.v14,
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.size32,
                                  ),
                                  child: Text(
                                    "All highlights and where to watch live matches on FIFA + I wonder how it loook,",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.v14,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.link,
                                      size: Sizes.size14,
                                    ),
                                    Gaps.h04,
                                    Text(
                                      "https://nomadcoders.co",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Gaps.v20,
                              ],
                            ),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: PersistentTabBar(),
                          ),
                        ],
                    body: TabBarView(
                      children: [
                        GridView.builder(
                          itemCount: 21,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: Sizes.size02,
                            mainAxisSpacing: Sizes.size02,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (context, index) => AspectRatio(
                            aspectRatio: 3 / 4,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: ExampleImage.example1,
                              image: ExampleImage.network1,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text("Page Two"),
                        ),
                      ],
                    )),
              ),
            ),
          ),
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
