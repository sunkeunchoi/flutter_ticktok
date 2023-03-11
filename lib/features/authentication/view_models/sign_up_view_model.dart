import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';
import 'package:flutter_ticktoc/utils.dart';
import 'package:go_router/go_router.dart';

import '../../onboarding/interests_screen.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepository);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(
      () => _authRepo.emailSignUp(
        form['email'],
        form['password'],
      ),
    );
    if (state.hasError) {
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
