import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class PromoteLocation extends StatefulWidget {
  const PromoteLocation({
    super.key,
    required this.ad,
    required this.price,
    required this.months,
  });

  final Ad ad;
  final String price;
  final int months;

  @override
  State<PromoteLocation> createState() => _PromoteLocationState();
}

class _PromoteLocationState extends State<PromoteLocation> {
  int typeLocationIndex = 1;
  int popularLocationIndex = -1;
  List<String> locations = [
    'Yaoundé',
    'douala',
    'bafoussam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.sp),
            child: AspectRatio(
              aspectRatio: 2.5,
              child: CachedNetworkImage(
                imageUrl: widget.ad.coverUrl,
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
                      color: widget.ad.adType.toBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      widget.ad.adType.translate(context),
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
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: context.textTheme.headlineMedium!.color,
                  ),
                ),
                Positioned(
                  top: 0,
                  width: 1.sw,
                  height: 60.sp,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.scaffoldBackgroundColor,
                          context.scaffoldBackgroundColor.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: 1.sw,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 5.h,
                      bottom: min(30.h, 15.h + Paddings.viewPadding.bottom),
                    ),
                    decoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(14.sp),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: context.textTheme.headlineMedium!.color!
                              .withOpacity(0.5),
                          offset: const Offset(-2.0, -2.0),
                          blurRadius: 12.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 5.sp,
                          width: 150.sp,
                          decoration: BoxDecoration(
                            color: context.textTheme.displayMedium!.color,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        10.heightSp,
                        AdRadioListTile(
                          value: 0,
                          groupValue: typeLocationIndex,
                          title:
                              AppLocalizations.of(context)!.my_current_location,
                          subtitle: AppLocalizations.of(context)!
                              .my_current_location_subtitle,
                          onChanged: (value) {
                            setState(() {
                              typeLocationIndex = value!;
                            });
                          },
                        ),
                        AdRadioListTile(
                          value: 1,
                          groupValue: typeLocationIndex,
                          title: AppLocalizations.of(context)!.manual_selection,
                          subtitle: AppLocalizations.of(context)!
                              .manual_selection_subtitle,
                          onChanged: (value) {
                            setState(() {
                              typeLocationIndex = value!;
                            });
                          },
                        ),
                        10.heightSp,
                        SizedBox(
                          height: 34.sp,
                          width: double.infinity,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35.w,
                            ),
                            itemBuilder: (context, index) => CustomChip<int>(
                              value: index,
                              groupValue: popularLocationIndex,
                              title: locations[index],
                              onChange: (index) => setState(
                                () {
                                  popularLocationIndex = index;
                                },
                              ),
                            ),
                            separatorBuilder: (context, index) => 12.widthSp,
                            itemCount: locations.length,
                          ),
                        ),
                        32.heightSp,
                        CustomElevatedButton(
                          label: AppLocalizations.of(context)!.continu,
                          onPressed: () => context.pushReplacement(
                            widget: PromoteAd(
                              ad: widget.ad,
                              price: widget.price,
                              months: widget.months,
                            ),
                          ),
                        ),
                        10.heightSp,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdRadioListTile extends StatelessWidget {
  const AdRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  final int value;
  final int groupValue;
  final String title;
  final String subtitle;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: RadioListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Styles.green,
        dense: true,
        title: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.poppins(
            fontSize: 14.sp,
            color: context.textTheme.displaySmall!.color,
            fontWeight: Styles.medium,
            height: 1.2,
          ),
        ),
        subtitle: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.poppins(
            fontSize: 16.sp,
            color: context.textTheme.displayLarge!.color,
            fontWeight: Styles.semiBold,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
