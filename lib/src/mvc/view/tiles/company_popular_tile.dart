import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';
import '../model_widgets.dart';
import '../tiles_models.dart';

class CompanyPopularTile extends StatelessWidget {
  const CompanyPopularTile({
    super.key,
    required this.name,
    required this.title,
    required this.logoUrl,
    required this.coverUrl,
    required this.isVerified,
  });

  final String name;
  final String title;
  final String logoUrl;
  final String coverUrl;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      width: 185.sp,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(
              height: 90.sp,
            ),
            child: CachedNetworkImage(
              imageUrl: coverUrl,
              fit: BoxFit.cover,
              color: Theme.of(context).textTheme.headlineSmall!.color,
              progressIndicatorBuilder: (context, url, progress) => Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  value: progress.progress,
                  color: Styles.green,
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                padding: EdgeInsets.all(8.sp),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headlineSmall!.color,
                  borderRadius: BorderRadius.circular(14.sp),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  title,
                  style: Styles.poppins(
                    fontSize: 14.sp,
                    fontWeight: Styles.semiBold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          CompanyHeaderTile(
            logoUrl: logoUrl,
            name: name,
            isVerified: isVerified,
            sizeOffset: 2.sp,
            padding: EdgeInsetsDirectional.only(start: 12.sp),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
