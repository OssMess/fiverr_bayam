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
import '../../tiles.dart';

class Page3CompanyAds extends StatelessWidget {
  const Page3CompanyAds({
    super.key,
    required this.userSession,
    required this.page,
  });

  final UserSession userSession;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueNotifier<AdsViewPage>>(
      builder: (context, viewPage, _) {
        bool promotedAds = viewPage.value == AdsViewPage.promotedAds;
        bool myAds = viewPage.value == AdsViewPage.myAds;
        return NotificationListener<ScrollNotification>(
          onNotification: myAds
              ? userSession.listAdsMy?.onMaxScrollExtent
              : userSession.listAdsPromoted?.onMaxScrollExtent,
          child: CustomRefreshIndicator(
            onRefresh: () async {
              if (myAds) {
                await userSession.listAdsMy?.refresh();
              } else {
                await userSession.listAdsPromoted?.refresh();
              }
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                16.sliverSp,
                SliverHeaderTile(
                  title: viewPage.value == AdsViewPage.myAds
                      ? AppLocalizations.of(context)!.my_ads
                      : AppLocalizations.of(context)!.promoted_ads,
                  trailing: AppLocalizations.of(context)!.m_ago(3),
                ),
                16.sliverSp,
                if (myAds) ...[
                  ChangeNotifierProvider.value(
                    value: userSession.listAdsMy,
                    child: Consumer<ListAdsMy>(
                      builder: (context, listAds, _) {
                        listAds.initData(callGet: page == 2);
                        if (listAds.isNull) {
                          return const CustomLoadingIndicator(
                            isSliver: true,
                          );
                        }
                        if (listAds.isEmpty) {
                          return SliverToBoxAdapter(
                            child: EmptyListView(
                              title: AppLocalizations.of(context)!.my_ads_empty,
                              svgPath: 'assets/images/Empty-pana.svg',
                            ),
                          );
                        }
                        return SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          sliver: SliverList.separated(
                            itemCount: listAds.childCount,
                            separatorBuilder: (context, index) => 12.heightSp,
                            itemBuilder: (_, index) {
                              if (index < listAds.length) {
                                return AdTile(
                                  userSession: userSession,
                                  ad: listAds.elementAt(index),
                                  expanded: true,
                                  showDates: promotedAds,
                                  onTapOptions: () => onTapAdOptions(
                                    context,
                                    listAds.elementAt(index),
                                  ),
                                );
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listAds.isNotNull,
                                  isLoading: listAds.isLoading,
                                  hasMore: listAds.hasMore,
                                  isSliver: false,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  70.sliverSp,
                ],
                (context.viewPadding.bottom + 20.sp).sliver,
              ],
            ),
          ),
        );
      },
    );
  }

  void onTapAdOptions(BuildContext context, Ad ad) {
    Dialogs.of(context).showDialogAdsOptions(
      context,
      userSession,
      ad,
    );
  }
}
