import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class SliverHeaderTile extends StatelessWidget {
  const SliverHeaderTile({
    super.key,
    required this.title,
    this.trailing,
    this.onTapTrailing,
  }) : assert(
            (trailing == null && onTapTrailing == null) || (trailing != null));

  final String title;
  final String? trailing;
  final void Function()? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Styles.poppins(
                  fontSize: 16.sp,
                  fontWeight: Styles.semiBold,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ),
            if (trailing != null)
              InkResponse(
                onTap: onTapTrailing,
                child: Text(
                  trailing!,
                  style: Styles.poppins(
                    fontSize: 10.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayMedium!.color,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
