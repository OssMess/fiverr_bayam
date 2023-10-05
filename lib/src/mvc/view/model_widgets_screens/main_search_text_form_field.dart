import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../model/change_notifiers.dart';
import '../model_widgets.dart';
import '../../../tools.dart';

class MainSearchTextFormField extends StatefulWidget {
  const MainSearchTextFormField({
    super.key,
    required this.notifierViewMode,
  });

  final NotifierPersonViewMode notifierViewMode;

  @override
  State<MainSearchTextFormField> createState() =>
      _MainSearchTextFormFieldState();
}

class _MainSearchTextFormFieldState extends State<MainSearchTextFormField> {
  TextEditingController controller = TextEditingController();
  String? filter;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: CustomTextFormField(
        height: 55.sp,
        controller: controller,
        hintText: AppLocalizations.of(context)!.what_are_you_looking_for,
        prefixIcon: widget.notifierViewMode.isInPageNormal
            ? AwesomeIcons.magnifying_glass
            : context.backButtonIcon,
        fillColor: Styles.green[50],
        onEditingComplete: () {
          widget.notifierViewMode.openPageResults();
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.done,
        onTap: () {
          widget.notifierViewMode.openPageSuggestions();
          return;
        },
        prefixOnTap: () {
          if (widget.notifierViewMode.isInPageNormal) return;
          if (widget.notifierViewMode.isInPageSuggestions ||
              widget.notifierViewMode.isInPageResults) {
            widget.notifierViewMode.reset();
            controller.text = '';
            FocusScope.of(context).unfocus();
            return;
          }
        },
      ),
    );
  }
}
