import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';
import '../../model/enums.dart';
import '../model_widgets.dart';
import '../tiles_models.dart';

class AdPremiumTile extends StatelessWidget {
  const AdPremiumTile({
    super.key,
    required this.name,
    required this.title,
    required this.logoUrl,
    required this.coverUrl,
    required this.isVerified,
    required this.adType,
  });

  final String name;
  final String title;
  final String logoUrl;
  final String coverUrl;
  final bool isVerified;
  final AdType adType;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      width: 300.sp,
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Expanded(
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
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headlineSmall!.color,
                  borderRadius: BorderRadius.circular(14.sp),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.sp,
                    vertical: 6.sp,
                  ),
                  decoration: BoxDecoration(
                    color: adType.toBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    adType.toTitle(context),
                    style: Styles.poppins(
                      fontSize: 12.sp,
                      fontWeight: Styles.semiBold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          4.heightSp,
          Text(
            'We are offering pesticide services for corn & wheat crops.',
            style: Styles.poppins(
              fontSize: 12.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          CustomDivider(
            padding: EdgeInsets.symmetric(vertical: 8.sp),
          ),
          CompanyHeaderTile(
            logoUrl: logoUrl,
            name: name,
            isVerified: isVerified,
            trailingUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Flag_of_Cameroon.png/640px-Flag_of_Cameroon.png',
          ),
        ],
      ),
    );
  }
}
