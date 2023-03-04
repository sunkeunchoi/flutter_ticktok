import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: tabs.length, vsync: this);
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");
  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _tapChanged() {
    if (_tabController.indexIsChanging) {
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_tapChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: "Search",
                    prefixIcon: GestureDetector(
                      onTap: () {
                        _onSearchSubmitted(_textEditingController.value.text);
                      },
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey.shade600,
                        ),
                        onTap: () {
                          _textEditingController.clear();
                        }),
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  FontAwesomeIcons.sliders,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Sizes.size16,
          ),
          isScrollable: true,
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          tabs: [for (var tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(
              Sizes.size06,
            ),
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Sizes.size10,
              mainAxisSpacing: Sizes.size10,
              childAspectRatio: 9 / 20,
            ),
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.size04,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: ExampleImage.example1,
                      image:
                          "https://images.unsplash.com/photo-1525340581945-d5e2b09641c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
                    ),
                  ),
                ),
                Gaps.v10,
                const Text(
                  "This is a very log caption for my tiktok that i am upload just wul jot sjot are kdite",
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.v05,
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: Sizes.size12,
                        backgroundImage: NetworkImage(
                          ExampleImage.profile1,
                        ),
                      ),
                      Gaps.h04,
                      const Expanded(
                        child: Text(
                          "My avatar is very very long words names",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gaps.h04,
                      FaIcon(
                        FontAwesomeIcons.heart,
                        size: Sizes.size16,
                        color: Colors.grey.shade600,
                      ),
                      Gaps.h02,
                      const Text(
                        "2.5M",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          for (var tab in tabs.skip(1))
            Center(
              child: Text(
                tab,
                style: const TextStyle(
                  fontSize: Sizes.size28,
                ),
              ),
            )
        ],
      ),
    );
  }
}
