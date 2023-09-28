import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class CompanyHeaderTile extends StatelessWidget {
  const CompanyHeaderTile({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.isVerified,
    this.sizeOffset = 0,
    this.trailingUrl,
    this.padding,
  });

  final String logoUrl;
  final String name;
  final bool isVerified;
  final double sizeOffset;
  final String? trailingUrl;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            height: 40.sp - sizeOffset,
            width: 40.sp - sizeOffset,
            padding: EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.textTheme.headlineMedium!.color!,
                width: 1.sp,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: context.textTheme.headlineSmall!.color,
              backgroundImage: CachedNetworkImageProvider(
                logoUrl,
              ),
            ),
          ),
          8.widthSp,
          Text(
            name,
            overflow: TextOverflow.fade,
            style: Styles.poppins(
              fontSize: 14.sp - sizeOffset,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
              height: 1.2,
            ),
          ),
          4.widthSp,
          if (isVerified)
            Icon(
              AwesomeIcons.badge_check,
              size: 16.sp - sizeOffset,
              color: Styles.blue,
            ),
          const Spacer(),
          if (trailingUrl != null)
            CircleAvatar(
              radius: 20.sp - sizeOffset,
              backgroundColor: context.textTheme.headlineSmall!.color,
              backgroundImage: CachedNetworkImageProvider(
                trailingUrl!,
              ),
            ),
        ],
      ),
    );
  }
}
