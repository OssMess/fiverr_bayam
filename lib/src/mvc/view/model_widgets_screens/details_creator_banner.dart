import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../model_widgets.dart';
import '../../../tools.dart';
import '../screens.dart';

class DetailsCreatorBanner extends StatelessWidget {
  const DetailsCreatorBanner({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.service,
  });

  final String name;
  final String photoUrl;
  final String service;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      onTap: () => context.push(widget: const ProfilePerson()),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.creator_information,
            style: Styles.poppins(
              fontSize: 12.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Row(
            children: [
              CircleAvatar(
                radius: 24.sp,
                backgroundColor: context.textTheme.headlineSmall!.color,
                backgroundImage: CachedNetworkImageProvider(
                  photoUrl,
                ),
              ),
              16.widthSp,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        8.widthSp,
                        Icon(
                          AwesomeIcons.badge_check,
                          size: 16.sp,
                          color: Styles.blue,
                        ),
                      ],
                    ),
                    Text(
                      service,
                      style: Styles.poppins(
                        fontSize: 11.sp,
                        fontWeight: Styles.regular,
                        color: context.textTheme.displayMedium!.color,
                      ),
                    ),
                  ],
                ),
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.thumbs_up,
                iconColor: context.textTheme.headlineMedium!.color,
              ),
              16.widthSp,
              const CustomFlatButton(
                icon: AwesomeIcons.flag_pennant,
                iconColor: Styles.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
