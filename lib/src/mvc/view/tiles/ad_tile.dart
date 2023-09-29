import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../screens.dart';
import '../tiles_models.dart';

class AdTile extends StatelessWidget {
  const AdTile({
    super.key,
    required this.ad,
    this.expanded = false,
    this.showDates = false,
    this.onTapOptions,
  });

  final Ad ad;
  final bool expanded;
  final bool showDates;
  final void Function()? onTapOptions;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: () => context.push(
        widget: DetailsAd(
          ad: ad,
        ),
      ),
      width: expanded ? double.infinity : 300.sp,
      height: expanded ? (showDates ? 295.sp : 250.sp) : null,
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: ad.coverUrl,
              fit: BoxFit.cover,
              color: context.textTheme.headlineSmall!.color,
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
                  color: context.textTheme.headlineSmall!.color,
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
                    color: ad.adType.toBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    ad.adType.translate(context),
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
          8.heightSp,
          Text(
            ad.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.poppins(
              fontSize: 13.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          CustomDivider(
            padding: EdgeInsets.symmetric(vertical: 8.sp),
          ),
          CompanyHeaderTile(
            logoUrl: ad.logoUrl,
            name: ad.name,
            isVerified: ad.isVerified,
            trailingUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Flag_of_Cameroon.png/640px-Flag_of_Cameroon.png',
            onTapOptions: onTapOptions,
          ),
          if (showDates) ...[
            CustomDivider(
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.start_date,
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        color: context.textTheme.displayMedium!.color,
                        fontWeight: Styles.medium,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      DateFormat(
                        DateFormat.YEAR_MONTH_DAY,
                        DateTimeUtils.of(context).getLanguageCode(),
                      ).format(
                        DateTime.now(),
                      ),
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        color: context.textTheme.displayLarge!.color,
                        fontWeight: Styles.semiBold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.end_date,
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        color: context.textTheme.displayMedium!.color,
                        fontWeight: Styles.medium,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      DateFormat(
                        DateFormat.YEAR_MONTH_DAY,
                        DateTimeUtils.of(context).getLanguageCode(),
                      ).format(
                        DateTime.now(),
                      ),
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        color: context.textTheme.displayLarge!.color,
                        fontWeight: Styles.semiBold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
