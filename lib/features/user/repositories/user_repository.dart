import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("profiles").doc(profile.uid).set(
          profile.toMap(),
        );
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("profiles").doc(uid).get();
    return doc.data();
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
