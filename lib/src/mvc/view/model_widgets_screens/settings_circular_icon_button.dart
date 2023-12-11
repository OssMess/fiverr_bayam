import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.label,
    this.file,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final XFile? file;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 54.sp,
            width: 54.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: context.textTheme.headlineSmall!.color,
              shape: BoxShape.circle,
              image: file != null
                  ? DecorationImage(
                      image: Image.file(File(file!.path)).image,
                      fit: BoxFit.cover,
                    )
                  : null,
              border: Border.all(
                color: context.scaffoldBackgroundColor,
                width: 3.sp,
              ),
            ),
            child: file == null
                ? Icon(
                    icon,
                    color: context.textTheme.displayMedium!.color,
                    size: 24.sp,
                  )
                : null,
          ),
          4.heightSp,
          Text(
            label,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
