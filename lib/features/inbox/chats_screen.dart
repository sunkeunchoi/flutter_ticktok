import 'package:flutter/material.dart';
import 'package:flutter_ticktoc/assets/image.dart';
import 'package:flutter_ticktoc/constants/sizes.dart';
import 'package:flutter_ticktoc/features/inbox/chat_detail_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  static Route route() =>
      MaterialPageRoute(builder: (context) => const ChatsScreen());
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final Duration _duration = const Duration(
    milliseconds: 300,
  );
  void _addItem() {
    if (_key.currentState == null) return;
    // _key.currentState?.insertItem(0);
    _key.currentState?.insertItem(
      _items.length,
      duration: _duration,
    );
    _items.add(_items.length);
  }

  void _deleteItem(int index) {
    _key.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Container(
          color: Colors.red,
          child: _makeTile(index),
        ),
      ),
      duration: _duration,
    );
    _items.removeAt(index);
  }

  void _onChatTap(int index) => context.pushNamed(
        ChatDetailScreen.routeName,
        params: {
          "chatId": index.toString(),
        },
      );

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: const CircleAvatar(
        radius: Sizes.size28,
        foregroundImage: NetworkImage(
          ExampleImage.profile1,
        ),
        child: Text("니꼬"),
      ),
      title: Text(
        "Lynn $index",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: const Text(
        "Don't forget to make video",
      ),
      trailing: Text(
        "2:16 PM",
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: Sizes.size12,
        ),
      ),
    );
  }

  final List<int> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Direct messages',
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
              size: Sizes.size20,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return ScaleTransition(
            key: UniqueKey(),
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: _makeTile(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
