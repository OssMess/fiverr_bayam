import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../extensions.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    super.key,
    required this.svgPath,
    required this.title,
  });

  final String svgPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        50.heightH,
        SizedBox(
          width: 0.6.sw,
          child: AspectRatio(
            aspectRatio: 1,
            child: SvgPicture.asset(
              svgPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        20.heightSp,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.sp),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.h4b1,
          ),
        ),
      ],
    );
  }
}
