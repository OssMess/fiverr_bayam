import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../model_widgets.dart';

class CustomTextFormFieldLabel extends StatelessWidget {
  const CustomTextFormFieldLabel({
    super.key,
    this.controller,
    required this.initialValue,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    required this.validator,
    this.onSave,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?) validator;
  final void Function(String?)? onSave;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.heightSp,
        IgnorePointer(
          child: Text(
            labelText,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
              height: 1.2,
            ),
          ),
        ),
        8.heightSp,
        CustomTextFormField(
          controller: controller,
          initialValue: initialValue,
          hintText: hintText,
          keyboardType: keyboardType,
          fillColor: context.textTheme.headlineSmall!.color,
          validator: validator,
          onSaved: onSave,
          onTap: onTap,
          readOnly: onTap != null,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
