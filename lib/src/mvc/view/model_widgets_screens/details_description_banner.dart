import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

import '../../../extensions.dart';
import '../model_widgets.dart';
import '../../../tools.dart';

class DetailsDescriptionBanner extends StatelessWidget {
  const DetailsDescriptionBanner({
    super.key,
    required this.description,
    required this.address,
    this.date,
    this.website,
    required this.tags,
    this.employees,
    required this.likes,
  });

  final String description;
  final String address;
  final String? date;
  final String? website;
  final List<String> tags;
  final int? employees;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: Styles.poppins(
              fontSize: 16.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Text(
            description,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          CustomDivider(
            height: 24.sp,
          ),
          DescriptionInfoTile(
            icon: AwesomeIcons.location_dot_outlined,
            label: address,
          ),
          if (website != null) ...[
            8.heightSp,
            DescriptionInfoTile(
              icon: Icons.link,
              label: website!,
            ),
          ],
          if (date != null) ...[
            8.heightSp,
            DescriptionInfoTile(
              icon: AwesomeIcons.calendar_clock_outlined,
              label: date!,
            ),
          ],
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 8.sp,
                  spacing: 8.sp,
                  children: tags
                      .map(
                        (text) => CustomFlatButton(
                          color: Styles.green[50],
                          child: Text(
                            text,
                            style: Styles.poppins(
                              fontSize: 14.sp,
                              fontWeight: Styles.medium,
                              color: Styles.green,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            children: [
              if (employees != null) ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.total_employees,
                        style: Styles.poppins(
                          fontSize: 13.sp,
                          fontWeight: Styles.regular,
                          color: context.textTheme.displayMedium!.color,
                        ),
                      ),
                      Text(
                        employees!.toString(),
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                16.widthSp,
              ],
              CustomFlatButton(
                child: Row(
                  children: [
                    Icon(
                      AwesomeIcons.heart,
                      color: Styles.green,
                      size: 20.sp,
                    ),
                    8.widthSp,
                    Text(
                      AppLocalizations.of(context)!.nb_likes(likes),
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                  ],
                ),
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.flag_pennant,
                iconColor: Styles.red,
                onTap: () {
                  //TODO implement report
                },
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.share_from_square,
                iconColor: Styles.green,
                color: context.scaffoldBackgroundColor,
                addBorder: true,
                onTap: () => Share.share(
                  'Share example, what to write here will be changed later',
                  subject: 'Title share',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DescriptionInfoTile extends StatelessWidget {
  const DescriptionInfoTile({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: Styles.green,
        ),
        8.widthSp,
        Text(
          label,
          style: Styles.poppins(
            fontSize: 14.sp,
            fontWeight: Styles.semiBold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
      ],
    );
  }
}
