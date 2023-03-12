import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/features/user/repositories/user_repository.dart';

import '../models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;
  late final AuthenticationRepository _authRepository;
  @override
  FutureOr<UserProfileModel> build() async {
    _repository = ref.read(userRepository);
    _authRepository = ref.read(authRepository);
    // await Future.delayed(const Duration(seconds: 5));
    if (_authRepository.isLoggedIn) {
      final profile = await _repository.findProfile(
        _authRepository.user!.uid,
      );
      if (profile != null) {
        UserProfileModel.fromMap(profile);
      }
    }
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

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _repository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
