import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> createProfile(UserProfileModel user) async {}
}

final userRepository = Provider(
  (ref) => UserRepository(),
);
