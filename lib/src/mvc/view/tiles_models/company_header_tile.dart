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
    this.onTapOptions,
  });

  final String? logoUrl;
  final String name;
  final bool isVerified;
  final double sizeOffset;
  final String? trailingUrl;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTapOptions;

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
              backgroundImage: logoUrl.isNotNullOrEmpty
                  ? CachedNetworkImageProvider(
                      logoUrl!,
                    )
                  : null,
            ),
          ),
          8.widthSp,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Styles.poppins(
                      fontSize: 14.sp - sizeOffset,
                      fontWeight: Styles.semiBold,
                      color: context.textTheme.displayLarge!.color,
                      height: 1.2,
                    ),
                  ),
                ),
                4.widthSp,
                if (isVerified)
                  Icon(
                    AwesomeIcons.badge_check,
                    size: 16.sp - sizeOffset,
                    color: Styles.blue,
                  ),
              ],
            ),
          ),
          if (trailingUrl != null)
            CircleAvatar(
              radius: 20.sp - sizeOffset,
              backgroundColor: context.textTheme.headlineSmall!.color,
              backgroundImage: CachedNetworkImageProvider(
                trailingUrl!,
              ),
            ),
          if (onTapOptions != null) ...[
            8.widthSp,
            InkResponse(
              onTap: onTapOptions,
              child: Container(
                height: 40.sp,
                width: 40.sp,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.textTheme.headlineSmall!.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.more_vert,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
