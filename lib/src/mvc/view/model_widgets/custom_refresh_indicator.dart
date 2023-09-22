import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';

import '../../../tools.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Styles.green,
      backgroundColor: context.textTheme.headlineSmall!.color,
      child: child,
    );
  }
}
