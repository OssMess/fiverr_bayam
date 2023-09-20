import 'package:flutter/material.dart';

import '../model_widgets.dart';

class CustomTrailingTile extends StatelessWidget {
  const CustomTrailingTile({
    super.key,
    required this.isNotNull,
    required this.isLoading,
    required this.hasMore,
    this.margin = const EdgeInsets.only(top: 20, bottom: 20),
    this.quarterTurns,
    this.isSliver = true,
  });

  final bool isNotNull;
  final bool isLoading;
  final bool hasMore;
  final EdgeInsetsGeometry margin;
  final int? quarterTurns;
  final bool isSliver;

  @override
  Widget build(BuildContext context) {
    var child = Builder(builder: (context) {
      if (!hasMore) {
        return Container(margin: margin);
      }
      if (isNotNull && isLoading) {
        return CustomLoadingIndicator(
          margin: margin,
          isSliver: false,
        );
      }
      if (isNotNull && !isLoading) {
        return RotatedBox(
          quarterTurns: quarterTurns ?? 0,
          child: CustomArrowTile(
            margin: margin,
          ),
        );
      }
      return Container(margin: margin);
    });
    if (isSliver) {
      return SliverToBoxAdapter(
        child: child,
      );
    } else {
      return child;
    }
  }
}
