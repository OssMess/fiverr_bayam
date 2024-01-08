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
    required this.elapsedOnline,
    this.description,
    this.actions,
    this.margin,
    this.onTapImage,
    this.onTapDescription,
  });

  final String displayName;
  final String? email;
  final ImageProvider<Object>? imageProfile;
  final bool isVerified;
  final String? elapsedOnline;
  final String? description;
  final List<ModelIconButton>? actions;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTapImage;
  final void Function()? onTapDescription;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24.sp),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        children: [
          if (onTapImage != null)
            badge.Badge(
              badgeStyle: badge.BadgeStyle(
                shape: badge.BadgeShape.circle,
                badgeColor: Styles.green[500]!,
                elevation: 0,
                padding: EdgeInsets.all(5.sp),
              ),
              badgeAnimation: const badge.BadgeAnimation.scale(
                toAnimate: false,
              ),
              position: badge.BadgePosition.bottomEnd(
                bottom: 4.sp,
                end: 4.sp,
              ),
              showBadge: true,
              badgeContent: Icon(
                Icons.camera_alt,
                size: 18.sp,
                color: Colors.black,
              ),
              child: InkResponse(
                onTap: onTapImage,
                child: CircleAvatar(
                  radius: 55.sp,
                  backgroundColor: context.textTheme.headlineSmall!.color,
                  foregroundImage: imageProfile,
                ),
              ),
            ),
          if (onTapImage == null)
            badge.Badge(
              badgeStyle: badge.BadgeStyle(
                shape: badge.BadgeShape.square,
                badgeColor: Styles.green[500]!,
                elevation: 0,
                borderSide: BorderSide(
                  color: context.scaffoldBackgroundColor,
                  width: 2.sp,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 4.sp,
                  horizontal: 6.sp,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              badgeAnimation: const badge.BadgeAnimation.scale(
                toAnimate: false,
              ),
              position: badge.BadgePosition.bottomEnd(
                bottom: 4.sp,
                end: 4.sp,
              ),
              showBadge: elapsedOnline.isNotNull,
              badgeContent: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      elapsedOnline ?? '0',
                      style: Styles.poppins(
                        fontSize: 12.sp,
                        fontWeight: Styles.semiBold,
                        color: elapsedOnline == '0'
                            ? Styles.green[500]!
                            : Colors.white,
                        height: 1.sp,
                      ),
                    ),
                  );
                },
              ),
              child: InkResponse(
                onTap: imageProfile != null
                    ? () => Dialogs.of(context)
                        .showProfileImageSlideShow(imageProfile!)
                    : null,
                child: CircleAvatar(
                  radius: 55.sp,
                  backgroundColor: context.textTheme.headlineSmall!.color,
                  foregroundImage: imageProfile,
                ),
              ),
            ),
          12.heightSp,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (true) ...[
                28.widthSp,
              ],
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 1.sw - 140.sp),
                child: Text(
                  displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Styles.poppins(
                    fontSize: 26.sp,
                    fontWeight: Styles.bold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
              ),
              if (true) ...[
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
