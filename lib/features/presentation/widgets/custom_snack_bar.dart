import 'package:flutter/material.dart';
import 'package:habits_tracker/core/themes/palette.dart';

enum SnackBarType { error, success }

class CustomSnackBar {
  static void _show(
    final BuildContext context,
    final String message, {
    required final Color color,
    required final Duration delay,
    required final Duration duration,
  }) {
    Future.delayed(delay).then(
      (_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          content: Text(message, textAlign: TextAlign.center),
          duration: duration,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ));
      },
    );
  }

  /// Show error [SnackBar]
  static void showError(
    final BuildContext context,
    final String message,
  ) {
    _show(
      context,
      message,
      color: Palette.lightRed,
      duration: const Duration(milliseconds: 2500),
      delay: const Duration(milliseconds: 0),
    );
  }

  /// Show success [SnackBar]
  static void showSuccess(
    final BuildContext context,
    final String message, {
    final SnackBarType type = SnackBarType.error,
    final Duration delay = const Duration(milliseconds: 0),
  }) {
    _show(
      context,
      message,
      color: Palette.lightGreenSalad,
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 500),
    );
  }

  /// Show info [SnackBar]
  static void showInfo(
    final BuildContext context,
    final String message,
  ) {
    _show(
      context,
      message,
      color: Palette.yellow,
      duration: const Duration(milliseconds: 1500),
      delay: const Duration(milliseconds: 0),
    );
  }
}
