import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  Future<UserCredential> emailSignUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  void signOut() {
    unawaited(_firebaseAuth.signOut());
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(
      GithubAuthProvider(),
    );
  }
}

final authRepository = Provider((ref) => AuthenticationRepository());
final authState = StreamProvider(
  (ref) {
    final repo = ref.read(authRepository);
    return repo.authStateChanges();
  },
);
