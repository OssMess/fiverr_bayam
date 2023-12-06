import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badge;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models_ui.dart';
import '../model_widgets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.displayName,
    required this.email,
    required this.imageProfile,
    required this.isVerified,
    required this.isOnline,
    this.description,
    this.actions,
    this.margin,
    this.onTapDescription,
  });

  final String displayName;
  final String? email;
  final ImageProvider<Object>? imageProfile;
  final bool isVerified;
  final bool isOnline;
  final String? description;
  final List<ModelIconButton>? actions;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTapDescription;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24.sp),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          badge.Badge(
            badgeStyle: badge.BadgeStyle(
              badgeColor: Styles.green[500]!,
              elevation: 0,
              borderSide: BorderSide(
                color: context.scaffoldBackgroundColor,
                width: 2.sp,
              ),
              padding: EdgeInsets.all(9.sp),
            ),
            badgeAnimation: const badge.BadgeAnimation.scale(
              toAnimate: false,
            ),
            position: badge.BadgePosition.bottomEnd(
              bottom: 4.sp,
              end: 4.sp,
            ),
            showBadge: true,
            child: CircleAvatar(
              radius: 55.sp,
              backgroundColor: context.textTheme.headlineSmall!.color,
              foregroundImage: imageProfile,
            ),
          ),
          12.heightSp,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                displayName,
                style: Styles.poppins(
                  fontSize: 26.sp,
                  fontWeight: Styles.bold,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
              if (isVerified) ...[
                8.widthSp,
                Icon(
                  AwesomeIcons.badge_check,
                  color: Styles.blue,
                  size: 20.sp,
                ),
              ],
            ],
          ),
          if (email.isNotNullOrEmpty)
            Text(
              email!,
              style: Styles.poppins(
                fontSize: 16.sp,
                fontWeight: Styles.regular,
                color: context.textTheme.displaySmall!.color,
              ),
            ),
          if (!description.isNullOrEmpty) ...[
            CustomDivider(
              height: 32.sp,
            ),
            InkResponse(
              onTap: onTapDescription,
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: Styles.poppins(
                  fontSize: 16.sp,
                  fontWeight: Styles.medium,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ),
          ],
          if (description.isNullOrEmpty && onTapDescription != null) ...[
            CustomDivider(
              height: 32.sp,
            ),
            InkResponse(
              onTap: onTapDescription,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.about,
                    textAlign: TextAlign.center,
                    style: Styles.poppins(
                      fontSize: 16.sp,
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayMedium!.color,
                    ),
                  ),
                  8.widthSp,
                  Icon(
                    Icons.edit,
                    color: context.textTheme.displayMedium!.color,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ],
          if ((actions ?? []).isNotEmpty) ...[
            CustomDivider(
              height: 32.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions!
                  .map(
                    (action) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.sp),
                      child: CustomFlatButton(
                        icon: action.icon,
                        iconSize: 24.sp,
                        addBorder: true,
                        color: context.scaffoldBackgroundColor,
                        padding: EdgeInsets.all(12.sp),
                        onTap: action.onPressed,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
