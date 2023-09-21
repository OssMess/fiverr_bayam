import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../tools.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  final T value;
  final T groupValue;
  final String label;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Styles.green,
      dense: true,
      title: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.poppins(
          fontSize: 16.sp,
          color: Theme.of(context).textTheme.displayLarge!.color,
          fontWeight: Styles.semiBold,
        ),
      ),
    );
  }
}
