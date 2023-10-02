import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class SettingsHeaderSubtitle extends StatelessWidget {
  const SettingsHeaderSubtitle({
    super.key,
    required this.title,
    this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;
  final String? subtitle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: Styles.poppins(
            fontSize: 18.sp,
            fontWeight: Styles.semiBold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
        if (!subtitle.isNullOrEmpty) ...[
          12.heightSp,
          Text(
            subtitle!,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
        ],
      ],
    );
  }
}
