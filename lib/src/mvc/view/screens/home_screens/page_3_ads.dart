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

class Page3CompanyAds extends StatefulWidget {
  const Page3CompanyAds({
    super.key,
    required this.userSession,
    required this.page,
  });

  final UserSession userSession;
  final int page;

  @override
  State<Page3CompanyAds> createState() => _Page3CompanyAdsState();
}

class _Page3CompanyAdsState extends State<Page3CompanyAds> {
  ValueNotifier<DateTime?> lastFetchNotifier = ValueNotifier<DateTime?>(null);

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueNotifier<AdsViewPage>>(
      builder: (context, viewPage, _) {
        bool myAds = viewPage.value == AdsViewPage.myAds;
        return NotificationListener<ScrollNotification>(
          onNotification: myAds
              ? widget.userSession.listAdsMy?.onMaxScrollExtent
              : widget.userSession.listAdsPromotedMy?.onMaxScrollExtent,
          child: CustomRefreshIndicator(
            onRefresh: () async {
              if (myAds) {
                await widget.userSession.listAdsMy?.refresh(
                  () => lastFetchNotifier.value = DateTime.now(),
                );
              } else {
                await widget.userSession.listAdsPromotedMy?.refresh(
                  () => lastFetchNotifier.value = DateTime.now(),
                );
              }
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: myAds
                  ? [
                      16.sliverSp,
                      ValueListenableBuilder(
                        valueListenable: lastFetchNotifier,
                        builder: (context, value, _) {
                          return SliverHeaderTile(
                            title: AppLocalizations.of(context)!.my_ads,
                            trailing: value == null
                                ? null
                                : AppLocalizations.of(context)!.m_ago(
                                    DateTime.now().difference(value).inMinutes),
                          );
                        },
                      ),
                      16.sliverSp,
                      ChangeNotifierProvider.value(
                        value: widget.userSession.listAdsMy,
                        child: Consumer<ListAdsMy>(
                          builder: (context, listAds, _) {
                            listAds.initData(
                              callGet: widget.page == 2,
                              onComplete: () {
                                lastFetchNotifier.value = DateTime.now();
                              },
                            );
                            if (listAds.isNull) {
                              return const CustomLoadingIndicator(
                                isSliver: true,
                              );
                            }
                            if (listAds.isEmpty) {
                              return SliverToBoxAdapter(
                                child: EmptyListView(
                                  title: AppLocalizations.of(context)!
                                      .my_ads_empty,
                                  svgPath: 'assets/images/Empty-pana.svg',
                                ),
                              );
                            }
                            return SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              sliver: SliverList.separated(
                                itemCount: listAds.childCount,
                                separatorBuilder: (context, index) =>
                                    12.heightSp,
                                itemBuilder: (_, index) {
                                  if (index < listAds.length) {
                                    return AdTile(
                                      userSession: widget.userSession,
                                      ad: listAds.elementAt(index),
                                      expanded: true,
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
                      (context.viewPadding.bottom + 20.sp).sliver,
                    ]
                  : [
                      16.sliverSp,
                      ValueListenableBuilder(
                          valueListenable: lastFetchNotifier,
                          builder: (context, value, _) {
                            return SliverHeaderTile(
                              title: AppLocalizations.of(context)!.promoted_ads,
                              trailing: value == null
                                  ? null
                                  : AppLocalizations.of(context)!.m_ago(
                                      DateTime.now()
                                          .difference(value)
                                          .inMinutes),
                            );
                          }),
                      16.sliverSp,
                      ChangeNotifierProvider.value(
                        value: widget.userSession.listAdsPromotedMy,
                        child: Consumer<ListAdsPromotedMy>(
                          builder: (context, listAdsPromotedMy, _) {
                            listAdsPromotedMy.initData(
                              callGet: widget.page == 2,
                              onComplete: () {
                                lastFetchNotifier.value = DateTime.now();
                              },
                            );
                            if (listAdsPromotedMy.isNull) {
                              return const CustomLoadingIndicator(
                                isSliver: true,
                              );
                            }
                            if (listAdsPromotedMy.isEmpty) {
                              return SliverToBoxAdapter(
                                child: EmptyListView(
                                  title: AppLocalizations.of(context)!
                                      .my_ads_promoted_empty,
                                  svgPath: 'assets/images/Empty-pana.svg',
                                ),
                              );
                            }
                            return SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              sliver: SliverList.separated(
                                itemCount: listAdsPromotedMy.childCount,
                                separatorBuilder: (context, index) =>
                                    12.heightSp,
                                itemBuilder: (_, index) {
                                  if (index < listAdsPromotedMy.length) {
                                    return AdPromotedTile(
                                      userSession: widget.userSession,
                                      adPromoted:
                                          listAdsPromotedMy.elementAt(index),
                                      expanded: true,
                                      // onTapOptions: () => onTapAdOptions(
                                      //   context,
                                      //   listAdsPromotedMy.elementAt(index).ad,
                                      // ),
                                    );
                                  } else {
                                    return CustomTrailingTile(
                                      isNotNull: listAdsPromotedMy.isNotNull,
                                      isLoading: listAdsPromotedMy.isLoading,
                                      hasMore: listAdsPromotedMy.hasMore,
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
      widget.userSession,
      ad,
    );
  }
}
