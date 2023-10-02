import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class AllAds extends StatelessWidget {
  const AllAds({
    super.key,
    required this.title,
    required this.listAds,
  });

  final String title;
  final List<Ad> listAds;

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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: CustomTextFormField(
              hintText: AppLocalizations.of(context)!.what_are_you_looking_for,
              prefixIcon: AwesomeIcons.magnifying_glass,
              fillColor: context.textTheme.headlineSmall!.color,
              onEditingComplete: () {},
              textInputAction: TextInputAction.done,
              suffix: SizedBox(
                height: 55.sp,
              ),
              height: 55.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: SettingsHeaderSubtitle(
              title: title,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(
                bottom: context.viewPadding.bottom,
              ),
              itemCount: listAds.length,
              separatorBuilder: (context, index) => 16.heightSp,
              itemBuilder: (_, index) => AdTile(
                ad: listAds[index],
                expanded: true,
                showDates: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
