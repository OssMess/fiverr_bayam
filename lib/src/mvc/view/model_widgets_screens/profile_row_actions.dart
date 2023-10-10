import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../model/models_ui.dart';
import '../model_widgets.dart';

class ProfileRowActions extends StatelessWidget {
  const ProfileRowActions({
    super.key,
    required this.actions,
  });

  final List<ModelIconButton> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actions
          .map(
            (action) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: CustomFlatButton(
                onTap: action.onPressed,
                icon: action.icon,
                iconColor: action.color,
                iconSize: 36.sp,
                addBorder: true,
                color: context.scaffoldBackgroundColor,
                padding: EdgeInsets.all(16.sp),
              ),
            ),
          )
          .toList(),
    );
  }
}
