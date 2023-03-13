import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/inbox/repositories/messages_repository.dart';

import '../models/message_model.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(messageRepository);
  }

  Future<void> sendMessage(String text) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final uid = ref.read(authRepository).uid!;
      final message = MessageModel(
        text: text,
        userId: uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repository.sendMessage(
          message: message, chatroomId: "fUoi31HT55neVZuPpKFd");
    });
  }
}

final messageProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc("fUoi31HT55neVZuPpKFd")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => MessageModel.fromMap(
                e.data(),
              ),
            )
            .toList(),
      );
});
