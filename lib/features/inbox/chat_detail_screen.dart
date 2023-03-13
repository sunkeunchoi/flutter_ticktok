import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/gaps.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/inbox/view_models/messages_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  const ChatDetailScreen({super.key, required this.chatId});
  static const routeName = "chatDetail";
  static const routeURL = ":chatId";
  static Route route({required String chatId}) =>
      MaterialPageRoute(builder: (context) => ChatDetailScreen(chatId: chatId));
  final String chatId;
  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  late final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    final text = _controller.text;
    if (text.isEmpty) return;
    ref.read(messageProvider.notifier).sendMessage(text);
    _controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messageProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size08,
          title: Text(
            "니꼬 (${widget.chatId})",
            style: const TextStyle(
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
          ref.watch(chatProvider).when(
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: 24,
                      left: 12,
                      right: 12,
                      bottom: MediaQuery.of(context).padding.bottom + 108,
                    ),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.watch(authRepository).uid!;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
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
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
                        hintText: "Send a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  IconButton(
                    color: Theme.of(context).colorScheme.onSurface,
                    icon: Icon(
                      isLoading ? Icons.hourglass_top : Icons.send,
                    ),
                    onPressed: isLoading ? null : _onSendPressed,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
