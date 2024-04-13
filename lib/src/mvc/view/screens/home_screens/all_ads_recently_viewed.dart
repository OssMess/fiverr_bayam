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

class AllAdsRecentlyViewed extends StatelessWidget {
  const AllAdsRecentlyViewed({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userSession.listAdsRecentlyViewed,
      child: Consumer<ListAdsRecentlyViewed>(
        builder: (context, listAdsRecentlyViewed, _) {
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
                    onNotification: listAdsRecentlyViewed.onMaxScrollExtent,
                    child: CustomRefreshIndicator(
                      onRefresh: listAdsRecentlyViewed.refresh,
                      child: Builder(
                        builder: (context) {
                          if (listAdsRecentlyViewed.isLoading) {
                            return const CustomLoadingIndicator(
                              isSliver: false,
                            );
                          }
                          if (listAdsRecentlyViewed.isEmpty) {
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
                            itemCount: listAdsRecentlyViewed.childCount,
                            separatorBuilder: (context, index) => 16.heightSp,
                            itemBuilder: (_, index) {
                              if (index < listAdsRecentlyViewed.length) {
                                return AdTile(
                                  userSession: userSession,
                                  ad: listAdsRecentlyViewed.elementAt(index),
                                  expanded: true,
                                );
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listAdsRecentlyViewed.isNotNull,
                                  isLoading: listAdsRecentlyViewed.isLoading,
                                  hasMore: listAdsRecentlyViewed.hasMore,
                                  isSliver: false,
                                );
                              }
                            },
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
