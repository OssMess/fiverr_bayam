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
  ScrollController listCompaniesPopularController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.userSession.listAds?.addControllerListener(listAdsController);
    widget.userSession.listCompaniesPopular
        ?.addControllerListener(listCompaniesPopularController);
    initDate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ListAds, ListCompaniesPopular>(
      builder: (context, listAds, listCompaniesPopular, _) {
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
                onEditingComplete: () {},
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
                      16.sliverSp,
                      SliverHeaderTile(
                        title: AppLocalizations.of(context)!.popular_companies,
                        trailing: '${AppLocalizations.of(context)!.show_all} >',
                        onTapTrailing: () => context.push(
                          widget: AllCompanies(
                            title:
                                AppLocalizations.of(context)!.popular_companies,
                            listCompanies: ListData.popularCompanies,
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
                              company: ListData.popularCompanies[index],
                            ),
                            separatorBuilder: (context, index) => 12.widthSp,
                          ),
                        ),
                      ),
                      // 8.sliverSp,
                      // SliverHeaderTile(
                      //   title: AppLocalizations.of(context)!.premium_ads,
                      //   trailing: '${AppLocalizations.of(context)!.show_all} >',
                      //   onTapTrailing: () => context.push(
                      //     widget: AllAdsPremium(
                      //       userSession: widget.userSession,
                      //       title: AppLocalizations.of(context)!.premium_ads,
                      //       listAds: ListData.premiumAds,
                      //     ),
                      //   ),
                      // ),
                      // SliverToBoxAdapter(
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     height: 290.sp,
                      //     child: ListView.separated(
                      //       scrollDirection: Axis.horizontal,
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 16.sp,
                      //         vertical: 12.sp,
                      //       ),
                      //       itemCount: ListData.premiumAds.length,
                      //       itemBuilder: (context, index) => AdTile(
                      //         userSession: widget.userSession,
                      //         ad: ListData.premiumAds[index],
                      //         expanded: false,
                      //       ),
                      //       separatorBuilder: (context, index) => 12.widthSp,
                      //     ),
                      //   ),
                      // ),
                      if (listAds.isNotEmpty) ...[
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
  }

  Future<void> refreshData() async {
    await widget.userSession.listCompaniesPopular!.refresh();
    await widget.userSession.listAds!.refresh();
  }

  bool get isLoading =>
      widget.userSession.listAds!.isNull ||
      widget.userSession.listCompaniesPopular!.isNull;
}
