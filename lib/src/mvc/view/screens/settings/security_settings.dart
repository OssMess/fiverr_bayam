import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class SecuritySettings extends StatelessWidget {
  const SecuritySettings({
    super.key,
  });

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
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.security_settings,
                    style: Styles.poppins(
                      fontSize: 16.sp,
                      fontWeight: Styles.semiBold,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                  16.heightSp,
                  CustomElevatedListTile(
                    title: AppLocalizations.of(context)!.change_password,
                    leadingIcon: AwesomeIcons.lock_rounded,
                    showContainerDecoration: false,
                    showTrailing: false,
                    padding: EdgeInsets.all(12.sp),
                    onTap: () {},
                  ),
                  16.heightSp,
                  CustomElevatedListTile(
                    title: AppLocalizations.of(context)!.forqot_password,
                    leadingIcon: AwesomeIcons.circle_question,
                    showContainerDecoration: false,
                    showTrailing: false,
                    padding: EdgeInsets.all(12.sp),
                    onTap: () {},
                  ),
                  16.heightSp,
                  CustomElevatedListTile(
                    title: AppLocalizations.of(context)!.delete_account,
                    leadingIcon: AwesomeIcons.trash_outlined,
                    leadingIconColor: Styles.red,
                    showContainerDecoration: false,
                    showTrailing: false,
                    padding: EdgeInsets.all(12.sp),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
