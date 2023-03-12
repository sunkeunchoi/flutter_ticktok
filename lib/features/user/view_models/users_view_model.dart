import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() async {
    // Fetch Profile
    return UserProfileModel.empty();
  }

  Future<void> createAccount(User user) async {
    state = AsyncValue.data(
      UserProfileModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
      ),
    );
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
