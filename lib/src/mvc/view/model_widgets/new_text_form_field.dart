import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';
import '../../../extensions.dart';

class NewTextFormField extends StatefulWidget {
  const NewTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.labelPrefixIcon,
    this.initialValue,
    this.prefix,
    this.suffix,
    this.readOnly = false,
    this.keyboardType,
    this.focusNode,
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
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function()? onEditingComplete;
  final void Function()? onTap;

  @override
  State<NewTextFormField> createState() => _NewTextFormFieldState();
}

class _NewTextFormFieldState extends State<NewTextFormField> {
  final FocusNode focusNode = FocusNode();
  String? error;

  bool get hasError => error != null;

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: (widget.focusNode ?? focusNode).requestFocus,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(color: hasError ? Styles.red : Styles.green),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //prefix
            if (widget.prefix != null) ...[
              widget.prefix!,
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
                        if (widget.labelPrefixIcon != null) ...[
                          Icon(
                            widget.labelPrefixIcon,
                            size: 16.sp,
                            color: context.textTheme.displayMedium!.color,
                          ),
                          8.widthSp,
                        ],
                        Text(
                          widget.labelText,
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
                      focusNode: widget.focusNode ?? focusNode,
                      initialValue: widget.initialValue,
                      validator: widget.validator != null
                          ? (value) {
                              setState(() {
                                error = widget.validator!(value);
                              });
                              return error;
                            }
                          : null,
                      onSaved: widget.onSaved,
                      onEditingComplete: widget.onEditingComplete,
                      onTap: widget.onTap,
                      readOnly: widget.readOnly,
                      keyboardType: widget.keyboardType,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: widget.hintText,
                        border: InputBorder.none,
                        hintStyle: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.regular,
                          color: context.textTheme.displayMedium!.color,
                          height: 1.2,
                        ),
                        errorStyle: Styles.poppins(
                          fontSize: 0,
                          height: 0,
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
            if (widget.suffix != null) ...[
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
