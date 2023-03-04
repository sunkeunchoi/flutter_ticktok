import 'package:flutter/material.dart';

enum AppColors {
  primary,
  secondary,
  tertiary,
  primaryContainer,
  secondaryContainer,
  tertiaryContainer,
  error,
  errorContainer,
  background,
  surface,
  surfaceVariant,
  inverseSurface;

  PairedColors getColors(BuildContext context) {
    switch (this) {
      case AppColors.primary:
        return context.primary;
      case AppColors.secondary:
        return context.secondary;
      case AppColors.tertiary:
        return context.tertiary;
      case AppColors.primaryContainer:
        return context.primaryContainer;
      case AppColors.secondaryContainer:
        return context.secondaryContainer;
      case AppColors.tertiaryContainer:
        return context.tertiaryContainer;
      case AppColors.error:
        return context.error;
      case AppColors.errorContainer:
        return context.errorContainer;
      case AppColors.background:
        return context.background;
      case AppColors.surface:
        return context.surface;
      case AppColors.surfaceVariant:
        return context.surfaceVariant;
      case AppColors.inverseSurface:
        return context.inverseSurface;
    }
  }
}

class PairedColors {
  final Color background;
  final Color main;
  PairedColors(this.background, this.main);
  PairedColors get invert => PairedColors(main, background);
}

extension AppColorsX on BuildContext {
  PairedColors get primary => PairedColors(
      Theme.of(this).colorScheme.primary, Theme.of(this).colorScheme.onPrimary);
  PairedColors get secondary => PairedColors(
      Theme.of(this).colorScheme.secondary,
      Theme.of(this).colorScheme.onSecondary);
  PairedColors get tertiary => PairedColors(Theme.of(this).colorScheme.tertiary,
      Theme.of(this).colorScheme.onTertiary);
  PairedColors get primaryContainer => PairedColors(
      Theme.of(this).colorScheme.primaryContainer,
      Theme.of(this).colorScheme.onPrimaryContainer);
  PairedColors get secondaryContainer => PairedColors(
      Theme.of(this).colorScheme.secondaryContainer,
      Theme.of(this).colorScheme.onSecondaryContainer);
  PairedColors get tertiaryContainer => PairedColors(
      Theme.of(this).colorScheme.tertiaryContainer,
      Theme.of(this).colorScheme.onTertiaryContainer);
  PairedColors get error => PairedColors(
      Theme.of(this).colorScheme.error, Theme.of(this).colorScheme.onError);
  PairedColors get errorContainer => PairedColors(
      Theme.of(this).colorScheme.errorContainer,
      Theme.of(this).colorScheme.onErrorContainer);
  PairedColors get background => PairedColors(
      Theme.of(this).colorScheme.background,
      Theme.of(this).colorScheme.onBackground);
  PairedColors get surface => PairedColors(
      Theme.of(this).colorScheme.surface, Theme.of(this).colorScheme.onSurface);
  PairedColors get surfaceVariant => PairedColors(
      Theme.of(this).colorScheme.surfaceVariant,
      Theme.of(this).colorScheme.onSurfaceVariant);
  PairedColors get inverseSurface => PairedColors(
      Theme.of(this).colorScheme.inverseSurface,
      Theme.of(this).colorScheme.onInverseSurface);
}
