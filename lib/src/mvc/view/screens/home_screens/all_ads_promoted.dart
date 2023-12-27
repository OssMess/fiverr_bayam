import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class AllAdsPromoted extends StatelessWidget {
  const AllAdsPromoted({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userSession.listAdsPromoted,
      child: Consumer<ListAdsPromoted>(
        builder: (context, listAdsPromoted, _) {
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
                  padding: EdgeInsets.all(16.sp),
                  child: SettingsHeaderSubtitle(
                    title: AppLocalizations.of(context)!.premium_ads,
                  ),
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: listAdsPromoted.onMaxScrollExtent,
                    child: CustomRefreshIndicator(
                      onRefresh: listAdsPromoted.refresh,
                      child: Builder(
                        builder: (context) {
                          if (listAdsPromoted.isLoading) {
                            return const CustomLoadingIndicator(
                              isSliver: false,
                            );
                          }
                          if (listAdsPromoted.isEmpty) {
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
                            itemCount: listAdsPromoted.childCount,
                            separatorBuilder: (context, index) => 16.heightSp,
                            itemBuilder: (_, index) {
                              if (index < listAdsPromoted.length) {
                                return AdTile(
                                  userSession: userSession,
                                  ad: listAdsPromoted.elementAt(index).ad,
                                  expanded: true,
                                );
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listAdsPromoted.isNotNull,
                                  isLoading: listAdsPromoted.isLoading,
                                  hasMore: listAdsPromoted.hasMore,
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
