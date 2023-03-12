import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  Future<void> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child("avatars/$fileName");
    final task = await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("profiles").doc(uid).update(data);
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
