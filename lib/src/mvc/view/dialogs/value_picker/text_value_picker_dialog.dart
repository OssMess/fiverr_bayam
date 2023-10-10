import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    required this.showPasteButton,
    required this.onPick,
    required this.mainAxisSize,
    required this.validator,
    required this.maxLines,
    required this.maxLength,
    required this.textInputType,
  });

  final String title;

  final String? initialValue;

  final String hintText;

  final bool showPasteButton;

  final void Function(String?) onPick;

  final MainAxisSize mainAxisSize;

  final int? maxLines;

  final int? maxLength;

  final TextInputType? textInputType;

  final String? Function(String?)? validator;

  @override
  State<TextValuePickerDialog> createState() => _TextValuePickerDialogState();
}

class _TextValuePickerDialogState extends State<TextValuePickerDialog> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBottomSheet(
      mainAxisSize: widget.mainAxisSize,
      continueButton: ModelTextButton(
        label: AppLocalizations.of(context)!.continu,
        fontColor: Styles.green,
        onPressed: () async {
          if (!_keyForm.currentState!.validate()) return;
          context.pop();
          widget.onPick(controller.text);
        },
      ),
      cancelButton: ModelTextButton(
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
        Form(
          key: _keyForm,
          autovalidateMode: AutovalidateMode.disabled,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 0.2.sh,
            ),
            child: CustomTextFormField(
              controller: controller,
              hintText: widget.hintText,
              suffixIcon: widget.showPasteButton ? Icons.paste : null,
              suffixOnTap: widget.showPasteButton
                  ? () async {
                      ClipboardData? cdata =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      if (cdata?.text == null) return;
                      controller.text = cdata!.text!;
                    }
                  : null,
              validator: widget.validator,
              maxLines: widget.maxLines ?? 1,
              maxLength: widget.maxLength,
              keyboardType: widget.textInputType,
            ),
          ),
        ),
      ],
    );
  }
}
