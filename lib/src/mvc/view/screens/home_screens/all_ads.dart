import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class AllAds extends StatelessWidget {
  const AllAds({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userSession.listAds,
      child: Consumer<ListAds>(
        builder: (context, listAds, _) {
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: CustomTextFormField(
                    hintText:
                        AppLocalizations.of(context)!.what_are_you_looking_for,
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
                    title: AppLocalizations.of(context)!.ads,
                  ),
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: listAds.onMaxScrollExtent,
                    child: CustomRefreshIndicator(
                      onRefresh: listAds.refresh,
                      child: Builder(
                        builder: (context) {
                          if (listAds.isLoading) {
                            return const CustomLoadingIndicator(
                              isSliver: false,
                            );
                          }
                          if (listAds.isEmpty) {
                            return EmptyListView(
                              svgPath: 'assets/images/Empty-pana.svg',
                              title: AppLocalizations.of(context)!.empty_ads,
                            );
                          }
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp)
                                .copyWith(
                              bottom: context.viewPadding.bottom,
                            ),
                            itemCount: listAds.length,
                            separatorBuilder: (context, index) => 16.heightSp,
                            itemBuilder: (_, index) => AdTile(
                              userSession: userSession,
                              ad: listAds.elementAt(index),
                              expanded: true,
                              showDates: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
