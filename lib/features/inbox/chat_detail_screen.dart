import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size08,
          title: const Text(
            "니꼬",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          leading: Stack(
            children: [
              const CircleAvatar(
                foregroundImage: NetworkImage(
                  ExampleImage.profile1,
                ),
                child: Text(
                  "니꼬",
                ),
              ),
              Positioned(
                right: -Sizes.size04,
                bottom: -Sizes.size04,
                width: Sizes.size24,
                height: Sizes.size24,
                child: Container(
                  // clipBehavior: Clip.hardEdge,
                  width: Sizes.size24,
                  height: Sizes.size24,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size05,
                    ),
                  ),
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
                color: Colors.black,
              ),
              Gaps.h20,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
              horizontal: Sizes.size14,
            ),
            itemCount: 10,
            separatorBuilder: (context, index) => Gaps.v10,
            itemBuilder: (context, index) {
              final isMine = index % 3 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color: isMine
                          ? Colors.blueAccent
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(
                          Sizes.size20,
                        ),
                        topRight: const Radius.circular(
                          Sizes.size20,
                        ),
                        bottomRight: Radius.circular(
                          !isMine ? Sizes.size20 : Sizes.size05,
                        ),
                        bottomLeft: Radius.circular(
                          isMine ? Sizes.size20 : Sizes.size05,
                        ),
                      ),
                    ),
                    child: const Text(
                      "This is a message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  top: Sizes.size10,
                  bottom: Sizes.size10,
                  right: Sizes.size10,
                ),
                color: Colors.grey.shade500,
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.size10,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    Container(
                      width: Sizes.size44,
                      height: Sizes.size44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.paperPlane,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}