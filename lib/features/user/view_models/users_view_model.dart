import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/user/repositories/user_repository.dart';

import '../models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;
  @override
  FutureOr<UserProfileModel> build() async {
    _repository = ref.read(userRepository);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(User user) async {
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
