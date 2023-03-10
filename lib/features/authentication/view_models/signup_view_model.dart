import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ticktoc/features/authentication/repositories/authentication_repository.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepository);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(
      () => _authRepo.signUp(
        form['email'],
        form['password'],
      ),
    );
  }
}

final signUpForm = StateProvider(
  (ref) => {},
);

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
