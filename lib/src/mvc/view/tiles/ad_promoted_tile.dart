import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../screens.dart';
import '../tiles_models.dart';

class AdPromotedTile extends StatelessWidget {
  const AdPromotedTile({
    super.key,
    required this.userSession,
    required this.adPromoted,
    this.expanded = false,
    // this.onTapOptions,
  });

  final UserSession userSession;
  final AdPromoted adPromoted;
  final bool expanded;
  // final void Function()? onTapOptions;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: adPromoted,
      child: Consumer<AdPromoted>(
        builder: (context, adPromoted, _) {
          return CustomElevatedContainer(
            onTap: () => Dialogs.of(context).runAsyncAction(
              future: () async => adPromoted.ad.reactions(userSession),
              onComplete: (_) {
                context.push(
                  widget: DetailsAd(
                    userSession: userSession,
                    ad: adPromoted.ad,
                  ),
                );
              },
            ),
            width: expanded ? double.infinity : 280.sp,
            height: expanded ? 325.sp : null,
            padding: EdgeInsets.all(10.sp),
            borderRadius: BorderRadius.circular(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: adPromoted.ad.imagesUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: adPromoted.ad.imagesUrl.first,
                          fit: BoxFit.cover,
                          color: context.textTheme.headlineSmall!.color,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Container(
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
                              borderRadius: BorderRadius.circular(10.sp),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.sp,
                                vertical: 6.sp,
                              ),
                              decoration: BoxDecoration(
                                color: adPromoted.ad.type.toBackgroundColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                adPromoted.ad.type.translate(context),
                                style: Styles.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: Styles.semiBold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                8.heightSp,
                Text(
                  adPromoted.ad.content,
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
                  color: context.textTheme.displayLarge!.color,
                ),
                8.heightSp,
                CompanyHeaderTile(
                  name: adPromoted.ad.author.displayName,
                  logoUrl: adPromoted.ad.author.imageProfileUrl,
                  isVerified: adPromoted.ad.author.isVerified,
                  countryCode: null,
                  // onTapOptions: onTapOptions,
                ),
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
                            adPromoted.startDate,
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
                            adPromoted.endDate,
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
            ),
          );
        },
      ),
    );
  }
}
