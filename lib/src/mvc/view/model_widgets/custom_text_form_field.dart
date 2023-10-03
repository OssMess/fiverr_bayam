import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';
import '../../../extensions.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.errorColor,
    this.initialValue,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor,
    this.prefixColor,
    this.focusNode,
    this.maxLength,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.contentPadding,
    this.margin,
    this.isHeightFixed = true,
    this.validator,
    this.prefixOnTap,
    this.suffixOnTap,
    this.suffix,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
    this.onSaved,
    this.height,
    this.colorBorderOnFocus = true,
    this.border,
    this.unfocusOnTapOutside = true,
    this.fontSize,
  }) : assert(
          ((prefixOnTap == null || prefixIcon != null) &&
              (suffixOnTap == null || suffixIcon != null)),
        );

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Color? errorColor;
  final String? initialValue;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final void Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final Color? fillColor;
  final Color? prefixColor;
  final FocusNode? focusNode;
  final bool isHeightFixed;
  final int? maxLength;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function()? prefixOnTap;
  final void Function()? suffixOnTap;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  final double? height;
  final bool colorBorderOnFocus;
  final InputBorder? border;
  final bool unfocusOnTapOutside;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    InputBorder outlineInputBorder = border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide(
            color: fillColor ?? context.textThemeDisplaySmall!.color!,
          ),
        );
    TextStyle style = Styles.poppins(
      fontSize: fontSize ?? 15.sp,
      fontWeight: Styles.medium,
      color: context.textTheme.displayLarge!.color,
      // height: 1.2,
    );
    Widget textFormField = TextFormField(
      initialValue: initialValue,
      controller: controller,
      style: style,
      onTap: onTap,
      readOnly: readOnly,
      enabled: enabled,
      onChanged: onChanged,
      focusNode: focusNode,
      validator: validator,
      maxLength: maxLength,
      // minLines: maxLines,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      obscureText: obscureText,
      onTapOutside:
          unfocusOnTapOutside ? (_) => FocusScope.of(context).unfocus() : null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        fillColor: fillColor,
        filled: fillColor != null,
        constraints: keyboardType != TextInputType.multiline
            ? BoxConstraints(
                minHeight: height ?? 45.sp,
                maxHeight: height ?? 45.sp,
              )
            : BoxConstraints(
                minHeight: height ?? 45.sp,
              ),
        alignLabelWithHint: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        labelStyle: style.copyWith(
          color: context.textTheme.displayLarge!.color,
          fontWeight: Styles.bold,
          fontSize: 15.sp,
        ),
        errorStyle: !isHeightFixed
            ? Styles.poppins(
                fontSize: 0,
                height: 0.3,
                color: errorColor,
              )
            : Styles.poppins(
                fontSize: 12.sp,
                height: 0.6,
                color: errorColor,
              ),
        hintStyle: style.copyWith(
          color: context.textThemeDisplaySmall!.color,
          fontWeight: Styles.regular,
        ),
        contentPadding: contentPadding ??
            (prefixIcon == null
                ? EdgeInsets.symmetric(
                    horizontal: 14.sp,
                    // vertical: 12.sp,
                  )
                : EdgeInsets.symmetric(
                    horizontal: 8.sp,
                    // vertical: 12.sp,
                  )),
        border: outlineInputBorder,
        focusedBorder: colorBorderOnFocus
            ? outlineInputBorder.copyWith(
                borderSide: const BorderSide(
                  color: Styles.green,
                ),
              )
            : outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: errorColor ?? Styles.red,
          ),
        ),
        disabledBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: context.textThemeDisplaySmall!.color!,
          ),
        ),
        // suffix: suffix,
        suffixIcon: suffix ??
            (suffixIcon != null
                ? InkResponse(
                    onTap: suffixOnTap,
                    child: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Icon(
                        suffixIcon,
                        size: 18.sp,
                        color: prefixColor ??
                            context.textThemeDisplayMedium!.color!,
                      ),
                    ),
                  )
                : null),
        prefixIcon: prefixIcon != null
            ? InkResponse(
                onTap: prefixOnTap,
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Icon(
                    prefixIcon,
                    size: 18.sp,
                    color:
                        prefixColor ?? context.textThemeDisplayMedium!.color!,
                  ),
                ),
              )
            : null,
        errorMaxLines: 1,
      ),
    );
    if (keyboardType == TextInputType.multiline) {
      textFormField = SizedBox(
        height: 250.sp,
        child: textFormField,
      );
    } else {
      if ((validator != null && isHeightFixed) &&
          maxLines == 1 &&
          keyboardType != TextInputType.multiline) {
        textFormField = SizedBox(
          height: 75.sp,
          child: textFormField,
        );
      }
    }
    if (margin != null) {
      textFormField = Padding(
        padding: margin!,
        child: textFormField,
      );
    }
    return textFormField;
  }
}
