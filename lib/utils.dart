import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

void showFirebaseErrorSnack(
    BuildContext context, FirebaseException? exception) {
  final snack = SnackBar(
    showCloseIcon: true,
    closeIconColor: Theme.of(context).colorScheme.onErrorContainer,
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    content: Text(
      exception?.message ?? "Something wen't wrong",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
