import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../tools.dart';
import '../../../../extensions.dart';
import '../../../model/models_ui.dart';
import '../../dialogs.dart';
import '../../model_widgets.dart';

class TextValuePickerDialog extends StatefulWidget {
  const TextValuePickerDialog({
    super.key,
    required this.title,
    required this.initialValue,
    required this.hintText,
    required this.onPick,
    required this.mainAxisSize,
  });

  final String title;

  final String? initialValue;

  final String hintText;
  final void Function(String?) onPick;
  final MainAxisSize mainAxisSize;

  @override
  State<TextValuePickerDialog> createState() => _TextValuePickerDialogState();
}

class _TextValuePickerDialogState extends State<TextValuePickerDialog> {
  String? text;

  @override
  void initState() {
    text = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBottomSheet(
      mainAxisSize: widget.mainAxisSize,
      continueAct: ModelTextButton(
        label: AppLocalizations.of(context)!.continu,
        fontColor: Styles.green,
        onPressed: () async {
          context.pop();
          widget.onPick(text);
        },
      ),
      cancelAct: ModelTextButton(
        label: AppLocalizations.of(context)!.close,
        fontColor: Styles.red,
        onPressed: () => context.pop(),
      ),
      children: [
        Text(
          widget.title,
          style: Styles.poppins(
            fontSize: 20.sp,
            fontWeight: Styles.bold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
        SizedBox(height: 40.sp),
        CustomTextFormField(
          hintText: widget.hintText,
          // prefixIcon: AwesomeIcons.magnifying_glass,
          // fillColor: Styles.green.shade50,
          // prefixColor: Styles.green,
          height: 55.sp,
          onChanged: (value) {
            text = value;
          },
        ),
      ],
    );
  }
}
