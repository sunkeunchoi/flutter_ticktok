import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sendMessage({
    required MessageModel message,
    required String chatroomId,
  }) async {
    await _db
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("texts")
        .add(message.toMap());
  }
}

final messageRepository = Provider((ref) => MessagesRepository());
