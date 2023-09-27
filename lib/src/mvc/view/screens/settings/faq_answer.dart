import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class FAQAnswer extends StatelessWidget {
  const FAQAnswer({
    super.key,
    required this.faq,
  });

  final FAQ faq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq.question,
                    style: Styles.poppins(
                      fontSize: 18.sp,
                      fontWeight: Styles.bold,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                  CustomDivider(
                    height: 48.sp,
                  ),
                  Text(
                    faq.answer,
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                  (context.viewPadding.bottom + 90.sp).height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
