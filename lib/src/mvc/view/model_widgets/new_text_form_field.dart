import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';
import '../../../extensions.dart';

class NewTextFormField extends StatelessWidget {
  const NewTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.labelPrefixIcon,
    this.initialValue,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.validator,
    this.onSaved,
    this.onEditingComplete,
    this.onTap,
  });

  final String labelText;
  final String hintText;
  final IconData? labelPrefixIcon;
  final String? initialValue;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return InkResponse(
      onTap: focusNode.requestFocus,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(color: context.primaryColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //prefix
            if (prefix != null) ...[
              prefix!,
              SizedBox(
                height: 40.sp,
                width: 32.sp,
                child: VerticalDivider(
                  color: context.textTheme.headlineMedium!.color,
                  width: 1.sp,
                  thickness: 1.sp,
                ),
              ),
            ],
            // body
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (labelPrefixIcon != null) ...[
                          Icon(
                            labelPrefixIcon,
                            size: 16.sp,
                            color: context.textTheme.displayMedium!.color,
                          ),
                          8.widthSp,
                        ],
                        Text(
                          labelText,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.medium,
                            color: context.textTheme.displayMedium!.color,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      focusNode: focusNode,
                      initialValue: initialValue,
                      validator: validator,
                      onSaved: onSaved,
                      onEditingComplete: onEditingComplete,
                      onTap: onTap,
                      readOnly: readOnly,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: hintText,
                        border: InputBorder.none,
                        hintStyle: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.regular,
                          color: context.textTheme.displayMedium!.color,
                          height: 1.2,
                        ),
                        contentPadding: EdgeInsets.only(
                          top: 6.sp,
                          bottom: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //suffix
            if (suffix != null) ...[
              16.widthSp,
              Icon(
                Icons.visibility_off,
                color: context.primary,
                size: 24.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
