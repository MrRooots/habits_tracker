import 'package:flutter/material.dart';

/// Custom scroll behavior that removes blue splashes on overscroll
class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    final BuildContext context,
    final Widget child,
    final ScrollableDetails details,
  ) {
    return child;
  }
}
