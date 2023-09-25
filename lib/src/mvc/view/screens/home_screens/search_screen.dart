// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badge;

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../settings.dart';
import '../../../../tools.dart';
import '../../screens.dart';
import '../../tiles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.notifierViewMode,
  });

  final NotifierViewMode notifierViewMode;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            /// Tab Bar: show in search view and results view
            if ([ViewPage.search, ViewPage.results]
                .contains(widget.notifierViewMode.value)) ...[
              16.sliverSp,
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.sp),
                  padding: EdgeInsets.all(2.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(
                      width: 1.sp,
                      color: context.textTheme.headlineMedium!.color!,
                    ),
                  ),
                  child: TabBar(
                    controller: tabController,
                    labelPadding: EdgeInsets.symmetric(vertical: 14.sp),
                    labelColor: Colors.white,
                    labelStyle: Styles.poppins(
                      fontSize: 15.sp,
                      fontWeight: Styles.semiBold,
                      height: 1.2,
                    ),
                    unselectedLabelColor:
                        context.textTheme.headlineLarge!.color!,
                    unselectedLabelStyle: Styles.poppins(
                      fontSize: 15.sp,
                      fontWeight: Styles.semiBold,
                      height: 1.2,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Styles.green,
                    ),
                    indicatorColor: Styles.green,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabAlignment: TabAlignment.fill,
                    // padding: EdgeInsets.all(16.sp),
                    tabs: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.products_and_services,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.companies,
                          ),
                        ],
                      ),
                    ],
                    onTap: (tab) {},
                  ),
                ),
              ),
            ],

            /// Tabs: categories and companies
            if (widget.notifierViewMode.isInPageSearch) ...[
              16.sliverSp,
              AnimatedBuilder(
                animation: tabController,
                // child: SliverToBoxAdapter(child: SizedBox.shrink()),
                builder: (context, child) {
                  /// Tab view 1: Categories list view
                  if (tabController.index == 0) {
                    List<Category> categories = [
                      Category.agriculture,
                      Category.livestock,
                      Category.fishing,
                      Category.phytosnitary,
                      Category.localFoodProducts,
                      Category.rentalStorageFacilities,
                    ];
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      sliver: SliverList.separated(
                        itemCount: categories.length,
                        itemBuilder: (context, index) => CategoryTile(
                          category: categories.elementAt(index),
                          onTap: () =>
                              widget.notifierViewMode.openPageResults(),
                        ),
                        separatorBuilder: (context, index) => 12.heightSp,
                      ),
                    );
                  }

                  /// Tab view 2: Companies
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    sliver: SliverList.separated(
                      itemCount: ListData.popularCompanies.length,
                      itemBuilder: (context, index) => CompanyTile(
                        company: ListData.popularCompanies.elementAt(index),
                        isExpanded: true,
                      ),
                      separatorBuilder: (context, index) => 12.heightSp,
                    ),
                  );
                },
              ),
            ],
            if (widget.notifierViewMode.isInPageSuggestions) ...[
              12.sliverSp,
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Recent searches',
                    style: Styles.poppins(
                      fontSize: 18.sp,
                      fontWeight: Styles.semiBold,
                      color: context.textTheme.displayLarge!.color,
                    ),
                  ),
                ),
              ),
              8.sliverSp,
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 32.sp),
                sliver: SliverList.separated(
                  itemCount: ListData.searchHistory.length,
                  itemBuilder: (context, index) => SearchHistoryTile(
                    searchHistory: ListData.searchHistory[index],
                    onTap: widget.notifierViewMode.openPageResults,
                    onClose: () => setState(() {
                      ListData.searchHistory.removeAt(index);
                    }),
                  ),
                  separatorBuilder: (context, index) => CustomDivider(
                    height: 12.sp,
                  ),
                ),
              ),
            ],
            if (widget.notifierViewMode.isInPageResults) ...[
              16.sliverSp,
              AnimatedBuilder(
                animation: tabController,
                // child: SliverToBoxAdapter(child: SizedBox.shrink()),
                builder: (context, child) {
                  /// Tab view 1: Ads search results
                  if (tabController.index == 0) {
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      sliver: SliverList.separated(
                        itemCount: ListData.ads.length,
                        separatorBuilder: (context, index) => 12.heightSp,
                        itemBuilder: (context, index) => AdTile(
                          ad: ListData.ads[index],
                          expanded: true,
                        ),
                      ),
                    );
                  }

                  /// Tab view 2: Companies search results
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    sliver: SliverList.separated(
                      itemCount: ListData.popularCompanies.length,
                      itemBuilder: (context, index) => CompanyTile(
                        company: ListData.popularCompanies.elementAt(index),
                        isExpanded: true,
                      ),
                      separatorBuilder: (context, index) => 12.heightSp,
                    ),
                  );
                },
              ),
            ],
            (context.viewPadding.bottom + 20.sp).sliver,
          ],
        ),
      ),
    );
  }
}
