import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';

class CustomAlertDialog<T> extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.yesAct,
    this.noAct,
    this.children,
    this.onComplete,
  });

  final String title;
  final String subtitle;
  final ModelTextButton yesAct;
  final ModelTextButton? noAct;
  final List<Widget>? children;
  final void Function(T)? onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 40.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Styles.poppins(
              fontSize: 20.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          24.heightSp,
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.regular,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          if (children != null) ...[
            12.heightSp,
            ...children!,
          ],
          32.heightSp,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (noAct != null)
                CustomElevatedButton(
                  label: noAct!.label,
                  color: noAct!.color,
                  fontColor: noAct!.fontColor,
                  elevation: 0,
                  fontSize: 16.sp,
                  fixedSize: Size(0.3.sw, 50.sp),
                  onPressed: () {
                    context.pop();
                    if (noAct!.onPressed != null) {
                      noAct!.onPressed!();
                    }
                  },
                ),
              16.widthSp,
              CustomElevatedButton(
                label: yesAct.label,
                color: yesAct.color,
                fontColor: yesAct.fontColor,
                elevation: 0,
                fontSize: 16.sp,
                fixedSize: Size(0.3.sw, 50.sp),
                onPressed: () {
                  context.pop();
                  dynamic result;
                  if (yesAct.onPressed != null) {
                    result = yesAct.onPressed!();
                  }
                  if (onComplete != null) {
                    onComplete!(result);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
