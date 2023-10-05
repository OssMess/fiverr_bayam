import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: controller,
                      hintText:
                          AppLocalizations.of(context)!.search_for_something,
                      prefixIcon: AwesomeIcons.magnifying_glass,
                      fillColor: context.textTheme.headlineSmall!.color,
                      onEditingComplete: () {},
                      textInputAction: TextInputAction.done,
                    ),
                    CustomDivider(
                      height: 48.sp,
                    ),
                    Text(
                      AppLocalizations.of(context)!.bayam_privacy_policy,
                      style: Styles.poppins(
                        fontSize: 18.sp,
                        fontWeight: Styles.bold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.last_update(
                        DateFormat.yMMMd(DateTimeUtils.of(context).languageCode)
                            .format(
                          DateTime.now(),
                        ),
                      ),
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayMedium!.color,
                      ),
                    ),
                    16.heightSp,
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur semper vestibulum nisi in facilisis. Vestibulum dapibus, ex id condimentum vulputate, dolor urna placerat eros, at tincidunt leo quam nec tellus. Integer quis ullamcorper augue. Integer pretium purus ac consequat scelerisque. Morbi feugiat neque id feugiat porttitor. Ut congue molestie dui, et imperdiet massa ornare et. Aliquam erat volutpat. Praesent laoreet ligula nulla, vitae placerat diam sodales a. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n\nDuis iaculis varius tellus at interdum. Nulla facilisi. Fusce eu augue sit amet nulla auctor accumsan. Etiam luctus lobortis scelerisque. Etiam in leo ornare, posuere dui sed, mattis sem. Curabitur efficitur faucibus molestie. Aenean finibus pellentesque commodo. Mauris sit amet lorem pellentesque, sollicitudin lacus ac, posuere massa. Morbi at bibendum mauris. Sed condimentum ultrices enim. Aenean cursus at tellus id mollis.\n\nUt auctor volutpat sapien. Aliquam egestas posuere convallis. Cras gravida odio at dui ornare, sit amet semper massa tempus. Donec vitae cursus dui. Nulla non urna imperdiet, tincidunt odio ut, gravida lorem. Phasellus ut lacus id nibh ultrices fermentum scelerisque sit amet justo. Aliquam ut suscipit ante, vel pulvinar tortor. Suspendisse tincidunt imperdiet malesuada. Phasellus rhoncus mollis ipsum in ultricies. Etiam blandit sapien sed velit ullamcorper, sed vestibulum sem dictum. Morbi rutrum venenatis odio. Cras rutrum vehicula faucibus.',
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    32.heightSp,
                    CustomElevatedButton(
                      label: AppLocalizations.of(context)!.agree_and_continue,
                      onPressed: context.pop,
                    ),
                    (context.viewPadding.bottom + 20.sp).height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
