import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class CustomChip<T> extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.value,
    required this.title,
    required this.groupValue,
    required this.onChange,
  });

  final T value;
  final String title;
  final T groupValue;
  final void Function(T) onChange;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onChange(value),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
          vertical: 8.sp,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Styles.green : context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            color: isSelected
                ? Styles.green
                : context.textTheme.headlineLarge!.color!,
          ),
        ),
        child: Text(
          title,
          style: Styles.poppins(
            fontSize: 14.sp,
            fontWeight: isSelected ? Styles.semiBold : Styles.regular,
            color: isSelected
                ? Colors.white
                : context.textTheme.headlineLarge!.color,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  bool get isSelected => groupValue == value;
}
