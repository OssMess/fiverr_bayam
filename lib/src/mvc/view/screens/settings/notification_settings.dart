import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    bool isOnEmail = true;
    bool isOnNotification = true;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsHeaderSubtitle(
                  title: AppLocalizations.of(context)!.notification_settings,
                ),
                16.heightSp,
                CustomSwitchListTile(
                  label: AppLocalizations.of(context)!.email_notifications,
                  value: isOnEmail,
                  onToggle: (value) {
                    isOnEmail = value;
                  },
                ),
                16.heightSp,
                CustomSwitchListTile(
                  label: AppLocalizations.of(context)!.app_notifications,
                  value: isOnNotification,
                  onToggle: (value) {
                    isOnNotification = value;
                  },
                ),
                (context.viewPadding.bottom + 20.sp).height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onToggle,
  });

  final bool value;
  final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    bool value = this.value;
    return StatefulBuilder(
      builder: (context, setState) {
        return FlutterSwitch(
          width: 40.sp,
          height: 22.sp,
          padding: 2.sp,
          toggleSize: 18.sp,
          value: value,
          onToggle: (val) {
            setState(() {
              value = val;
            });
            onToggle(val);
          },
          activeColor: Styles.green,
          inactiveColor: context.textTheme.displaySmall!.color!,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.white,
        );
      },
    );
  }
}

class CustomSwitchListTile extends StatelessWidget {
  const CustomSwitchListTile({
    super.key,
    required this.label,
    required this.value,
    required this.onToggle,
  });

  final String label;
  final bool value;
  final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return CustomFlatButton(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Styles.poppins(
                fontSize: 14.sp,
                fontWeight: Styles.medium,
                color: context.textTheme.displayMedium!.color,
              ),
            ),
          ),
          CustomSwitch(
            value: value,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
