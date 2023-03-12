import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/utils.dart';
import 'package:go_router/go_router.dart';

import '../../onboarding/interests_screen.dart';
import '../../user/view_models/users_view_model.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepository);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(() async {
      final users = ref.read(usersProvider.notifier);
      final userCredential = await _authRepo.emailSignUp(
        form['email'],
        form['password'],
      );
      users.createProfile(userCredential.user!);
    });

    if (state.hasError) {
      log("${state.error}");
      showFirebaseErrorSnack(context, state.error as FirebaseException);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }

  signOut() => _authRepo.signOut();
}

final signUpForm = StateProvider(
  (ref) => {},
);

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
