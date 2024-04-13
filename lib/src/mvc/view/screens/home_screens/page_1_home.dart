import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';
import '../../tiles.dart';

class Page1Home extends StatefulWidget {
  const Page1Home({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<Page1Home> createState() => _Page1HomeState();
}

class _Page1HomeState extends State<Page1Home> {
  ScrollController listAdsController = ScrollController();
  ScrollController listAdsRecentlyViewedController = ScrollController();
  ScrollController listAdsPromotedController = ScrollController();
  ScrollController listCompaniesPopularController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.userSession.listAds?.addControllerListener(listAdsController);
    widget.userSession.listAdsRecentlyViewed
        ?.addControllerListener(listAdsRecentlyViewedController);
    widget.userSession.listAdsPromoted
        ?.addControllerListener(listAdsController);
    widget.userSession.listCompaniesPopular
        ?.addControllerListener(listCompaniesPopularController);
    initDate();
  }

  @override
  void dispose() {
    listAdsController.dispose();
    listAdsRecentlyViewedController.dispose();
    listAdsPromotedController.dispose();
    listCompaniesPopularController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<ListAds?, ListAdsRecentlyViewed?, ListCompaniesPopular?,
        ListAdsPromoted?>(
      builder: (context, listAds, listAdsRecentlyViewed, listCompaniesPopular,
          listAdsPromoted, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: CustomTextFormField(
                hintText:
                    AppLocalizations.of(context)!.what_are_you_looking_for,
                prefixIcon: AwesomeIcons.magnifying_glass,
                fillColor: context.textTheme.headlineSmall!.color,
                onTap: () => context.push(
                  widget: AllAdsSearch(
                    userSession: widget.userSession,
                  ),
                ),
                readOnly: true,
                textInputAction: TextInputAction.done,
                suffix: SizedBox(
                  height: 55.sp,
                ),
                height: 55.sp,
              ),
            ),
            Expanded(
              child: CustomRefreshIndicator(
                onRefresh: refreshData,
                child: Builder(builder: (context) {
                  if (isLoading) {
                    return const CustomLoadingIndicator(
                      isSliver: false,
                    );
                  }
                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      8.sliverSp,
                      if (listCompaniesPopular!.isNotEmpty) ...[
                        8.sliverSp,
                        SliverHeaderTile(
                          title:
                              AppLocalizations.of(context)!.popular_companies,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () => context.push(
                            widget: AllCompanies(
                              userSession: widget.userSession,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 190.sp,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: listCompaniesPopularController,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: listCompaniesPopular.length,
                              itemBuilder: (context, index) => CompanyTile(
                                userSession: widget.userSession,
                                userMin: listCompaniesPopular.elementAt(index),
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                      ],
                      if (listAdsPromoted!.isNotEmpty) ...[
                        8.sliverSp,
                        SliverHeaderTile(
                          title: AppLocalizations.of(context)!.premium_ads,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () => context.push(
                            widget: AllAdsPromoted(
                              userSession: widget.userSession,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 290.sp,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: listAdsPromotedController,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: listAdsPromoted.length,
                              itemBuilder: (context, index) => AdTile(
                                userSession: widget.userSession,
                                ad: listAdsPromoted.elementAt(index).ad,
                                expanded: false,
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                      ],
                      if (listAds!.isNotEmpty) ...[
                        8.sliverSp,
                        SliverHeaderTile(
                          title: AppLocalizations.of(context)!.ads,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () => context.push(
                            widget: AllAds(
                              userSession: widget.userSession,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 265.sp,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: listAdsController,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: listAds.length,
                              itemBuilder: (context, index) => AdTile(
                                userSession: widget.userSession,
                                ad: listAds.elementAt(index),
                                expanded: false,
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                      ],
                      if (listAdsRecentlyViewed!.isNotEmpty) ...[
                        8.sliverSp,
                        SliverHeaderTile(
                          title: AppLocalizations.of(context)!.recently_viewed,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () => context.push(
                            widget: AllAdsRecentlyViewed(
                              userSession: widget.userSession,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 265.sp,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: listAdsRecentlyViewedController,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: listAdsRecentlyViewed.length,
                              itemBuilder: (context, index) => AdTile(
                                userSession: widget.userSession,
                                ad: listAdsRecentlyViewed.elementAt(index),
                                expanded: false,
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                      ],
                      (context.viewPadding.bottom + 20.sp).sliver,
                    ],
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> initDate() async {
    await widget.userSession.listCompaniesPopular!.initData(callGet: true);
    await widget.userSession.listAds!.initData(callGet: true);
    await widget.userSession.listAdsPromoted!.initData(callGet: true);
  }

  Future<void> refreshData() async {
    await widget.userSession.listCompaniesPopular!.refresh();
    await widget.userSession.listAds!.refresh();
    await widget.userSession.listAdsPromoted!.refresh();
  }

  bool get isLoading =>
      (widget.userSession.listAds?.isNull ?? true) ||
      (widget.userSession.listAdsPromoted?.isNull ?? true) ||
      (widget.userSession.listCompaniesPopular?.isNull ?? true);

  bool get isEmpty =>
      widget.userSession.listAds!.isEmpty &&
      widget.userSession.listAdsPromoted!.isEmpty &&
      widget.userSession.listCompaniesPopular!.isEmpty;
}
