import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../model/change_notifiers.dart';
import '../model_widgets.dart';
import '../../../tools.dart';

class MainSearchTextFormField extends StatelessWidget {
  const MainSearchTextFormField({
    super.key,
    required this.notifierViewMode,
  });

  final NotifierViewMode notifierViewMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: CustomTextFormField(
        hintText: AppLocalizations.of(context)!.what_are_you_looking_for,
        prefixIcon: notifierViewMode.isInPageNormal
            ? AwesomeIcons.magnifying_glass
            : context.backButtonIcon,
        fillColor: context.textTheme.headlineSmall!.color,
        onTap: notifierViewMode.isInPageNormal
            ? notifierViewMode.openPageSearch
            : null,
        prefixOnTap: notifierViewMode.reset,
        readOnly: notifierViewMode.isInPageNormal,
      ),
    );
  }
}
