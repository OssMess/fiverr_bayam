import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  NotifierPersonViewMode notifierViewMode = NotifierPersonViewMode();
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
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: notifierViewMode,
                builder: (context, _, __) {
                  return Column(
                    children: [
                      MainSearchTextFormField(
                        notifierViewMode: notifierViewMode,
                      ),

                      /// Tabs: categories and companies
                      if (notifierViewMode.isInPageNormal) ...[
                        16.heightSp,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: CustomTabBar(
                            controller: tabController,
                            tabs: [
                              AppLocalizations.of(context)!
                                  .products_and_services,
                              AppLocalizations.of(context)!.companies,
                            ],
                            onTap: (tab) {},
                          ),
                        ),
                        AnimatedBuilder(
                          animation: tabController,
                          // child: SliverToBoxAdapter(child: SizedBox.shrink()),
                          builder: (context, child) {
                            List<Category> categories = [
                              Category.agriculture,
                              Category.livestock,
                              Category.fishing,
                              Category.phytosnitary,
                              Category.localFoodProducts,
                              Category.rentalStorageFacilities,
                            ];
                            return Expanded(
                              child: ListView.separated(
                                // shrinkWrap: true,
                                padding: EdgeInsets.all(16.sp),
                                itemCount: categories.length,
                                itemBuilder: (context, index) => CategoryTile(
                                  category: categories.elementAt(index),
                                  onTap: () =>
                                      notifierViewMode.openPageResults(),
                                ),
                                separatorBuilder: (context, index) =>
                                    12.heightSp,
                              ),
                            );
                          },
                        ),
                      ],
                      if (notifierViewMode.isInPageSuggestions) ...[
                        12.heightSp,
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp),
                            child: Text(
                              AppLocalizations.of(context)!.recent_searches,
                              style: Styles.poppins(
                                fontSize: 18.sp,
                                fontWeight: Styles.semiBold,
                                color: context.textTheme.displayLarge!.color,
                              ),
                            ),
                          ),
                        ),
                        8.heightSp,
                        Expanded(
                          child: ListView.separated(
                            // shrinkWrap: true,
                            padding: EdgeInsets.all(16.sp),
                            itemCount: ListData.searchHistory.length,
                            itemBuilder: (context, index) => SearchHistoryTile(
                              searchHistory: ListData.searchHistory[index],
                              onTap: notifierViewMode.openPageResults,
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
                      if (notifierViewMode.isInPageResults) ...[
                        16.heightSp,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          child: CustomTabBar(
                            controller: tabController,
                            tabs: [
                              AppLocalizations.of(context)!
                                  .products_and_services,
                              AppLocalizations.of(context)!.companies,
                            ],
                            onTap: (tab) {},
                          ),
                        ),
                        16.heightSp,
                        AnimatedBuilder(
                          animation: tabController,
                          // child: SliverToBoxAdapter(child: SizedBox.shrink()),
                          builder: (context, child) {
                            /// Tab view 1: Ads search results
                            if (tabController.index == 0) {
                              return Expanded(
                                child: ListView.separated(
                                  // shrinkWrap: true,
                                  padding: EdgeInsets.all(16.sp),
                                  itemCount: ListData.ads.length,
                                  separatorBuilder: (context, index) =>
                                      12.heightSp,
                                  itemBuilder: (context, index) => AdTile(
                                    ad: ListData.ads[index],
                                    expanded: true,
                                  ),
                                ),
                              );
                            }

                            /// Tab view 2: Companies search results
                            return Expanded(
                              child: ListView.separated(
                                // shrinkWrap: true,
                                padding: EdgeInsets.all(16.sp),
                                itemCount: ListData.popularCompanies.length,
                                itemBuilder: (context, index) => CompanyTile(
                                  company: ListData.popularCompanies
                                      .elementAt(index),
                                  isExpanded: true,
                                ),
                                separatorBuilder: (context, index) =>
                                    12.heightSp,
                              ),
                            );
                          },
                        ),
                      ],
                      // (context.viewPadding.bottom + 20.sp).height,
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
