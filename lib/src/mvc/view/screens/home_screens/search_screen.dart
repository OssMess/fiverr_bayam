import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../controller/hives.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  NotifierPersonViewMode notifierViewMode = NotifierPersonViewMode();
  late TabController tabController;
  late ListAdsFilter listAdsFilter;
  String? content;
  String? country;
  String? region;
  AdType? type;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    listAdsFilter = ListAdsFilter(userSession: widget.userSession);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: listAdsFilter),
      ],
      child: Scaffold(
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
              child: ValueListenableBuilder(
                  valueListenable: notifierViewMode,
                  builder: (context, _, __) {
                    return Column(
                      children: [
                        //search text form field
                        //TODO on search text content
                        MainSearchTextFormField(
                          onSearch: (content) {
                            this.content = content;
                            callAdsFilter();
                          },
                          notifierViewMode: notifierViewMode,
                        ),
                        16.heightSp,
                        //filters
                        SizedBox(
                          height: 34.sp,
                          width: double.infinity,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.sp,
                            ),
                            children: [
                              //filter by country
                              Stack(
                                children: [
                                  FilterCard(
                                    text: country,
                                    filter: FilterType.country,
                                    onTap: () {},
                                  ),
                                  Opacity(
                                    opacity: 0,
                                    child: CountryCodePicker(
                                      initialSelection: 'CM',
                                      showCountryOnly: true,
                                      enabled: true,
                                      favorite: const ['+237'],
                                      comparator: (a, b) =>
                                          b.name!.compareTo(a.name!),
                                      boxDecoration: BoxDecoration(
                                        color: context.scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                      ),
                                      textStyle: Styles.poppins(
                                        fontWeight: Styles.medium,
                                        color: context
                                            .textTheme.displayMedium!.color,
                                        fontSize: 14.sp,
                                        height: 1.2,
                                      ),
                                      onChanged: (code) {
                                        setState(() {
                                          country = code.name;
                                          region = null;
                                        });
                                        callAdsFilter();
                                      },
                                      padding: EdgeInsets.zero,
                                      flagWidth: 30.sp,
                                    ),
                                  ),
                                ],
                              ),
                              12.widthSp,
                              //filter by region
                              FilterCard(
                                text: region,
                                filter: FilterType.region,
                                onTap: () {
                                  Dialogs.of(context).showTextValuePickerDialog(
                                    title: AppLocalizations.of(context)!
                                        .filter_by_region,
                                    hintText: AppLocalizations.of(context)!
                                        .filter_by_region,
                                    initialvalue: region,
                                    showPasteButton: false,
                                    onPick: (value) {
                                      setState(() {
                                        region = value;
                                        country = null;
                                      });
                                      callAdsFilter();
                                    },
                                  );
                                },
                              ),
                              12.widthSp,
                              FilterCard(
                                text: type?.translate(context),
                                filter: FilterType.adtype,
                                onTap: () {
                                  Dialogs.of(context)
                                      .showSingleValuePickerDialog(
                                    mainAxisSize: MainAxisSize.min,
                                    title: AppLocalizations.of(context)!
                                        .filter_ads_by_type,
                                    values: [
                                      AppLocalizations.of(context)!.all,
                                      AdType.rent.translate(context),
                                      AdType.sell.translate(context),
                                      AdType.want.translate(context),
                                    ],
                                    initialvalue: type?.translate(context) ??
                                        AppLocalizations.of(context)!.all,
                                    onPick: (value) {
                                      setState(() {
                                        type = {
                                          AdType.rent.translate(context):
                                              AdType.rent,
                                          AdType.sell.translate(context):
                                              AdType.sell,
                                          AdType.want.translate(context):
                                              AdType.want,
                                          AppLocalizations.of(context)!.all:
                                              null,
                                        }[value];
                                      });
                                      callAdsFilter();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        /// results are being loaded
                        // if (notifierViewMode.isInLoadingPage) ...[
                        //   const CustomLoadingIndicator(
                        //     isSliver: false,
                        //   ),
                        // ],
                        /// Tabs: categories and companies
                        /// results are ready, or not yet queried
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
                              List<AdCategory> categories = [
                                AdCategory.agriculture,
                                AdCategory.livestock,
                                AdCategory.fishing,
                                AdCategory.phytosnitary,
                                AdCategory.localFoodProducts,
                                AdCategory.rentalStorageFacilities,
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

                        /// user in suggestions page
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
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Expanded(
                                child: ListView.separated(
                                  // shrinkWrap: true,
                                  padding: EdgeInsets.all(16.sp),
                                  itemCount: HiveSearchHistory.list.length,
                                  itemBuilder: (context, index) =>
                                      SearchHistoryTile(
                                    searchHistory:
                                        HiveSearchHistory.list[index],
                                    onTap: () {
                                      notifierViewMode.openPageResults();
                                      //FIXME on filter by category sub
                                    },
                                    onClose: () => setState(
                                      () {
                                        HiveSearchHistory.delete(
                                            HiveSearchHistory.list[index]);
                                      },
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      CustomDivider(
                                    height: 12.sp,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],

                        /// user is the results page
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
                              if (notifierViewMode.isInTabProducts) {
                                return Consumer<ListAdsFilter>(
                                  builder: (context, listAdsFilter, _) {
                                    if (listAdsFilter.isLoading) {
                                      return const CustomLoadingIndicator(
                                        isSliver: false,
                                      );
                                    }
                                    if (listAdsFilter.isEmpty) {}
                                    return Expanded(
                                      child: ListView.separated(
                                        // shrinkWrap: true,
                                        padding: EdgeInsets.all(16.sp),
                                        itemCount: listAdsFilter.length,
                                        separatorBuilder: (context, index) =>
                                            12.heightSp,
                                        itemBuilder: (context, index) => AdTile(
                                          userSession: widget.userSession,
                                          ad: listAdsFilter.elementAt(index),
                                          expanded: true,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox.shrink();
                              }

                              /// //FIXME searchable ads
                              /// Tab view 1: Ads search results
                              // if (tabController.index == 0) {
                              //   return Expanded(
                              //     child: ListView.separated(
                              //       // shrinkWrap: true,
                              //       padding: EdgeInsets.all(16.sp),
                              //       itemCount: ListData.ads.length,
                              //       separatorBuilder: (context, index) =>
                              //           12.heightSp,
                              //       itemBuilder: (context, index) => AdTile(
                              //         userSession: widget.userSession,
                              //         ad: ListData.ads[index],
                              //         expanded: true,
                              //       ),
                              //     ),
                              //   );
                              // }
                              /// //FIXME searchable popular companies
                              /// Tab view 2: Companies search results
                              // return Expanded(
                              //   child: ListView.separated(
                              //     // shrinkWrap: true,
                              //     padding: EdgeInsets.all(16.sp),
                              //     itemCount: ListData.popularCompanies.length,
                              //     itemBuilder: (context, index) => CompanyTile(
                              //       company: ListData.popularCompanies
                              //           .elementAt(index),
                              //       isExpanded: true,
                              //     ),
                              //     separatorBuilder: (context, index) =>
                              //         12.heightSp,
                              //   ),
                              // );
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
      ),
    );
  }

  void callAdsFilter() {
    // notifierViewMode.openPageLoading();
    listAdsFilter.filter(
      content: content,
      country: country,
      region: region,
      type: type,
      onComplete: () {},
    );
    notifierViewMode.openPageResults();
  }
}

class FilterCard extends StatelessWidget {
  const FilterCard({
    super.key,
    required this.text,
    required this.filter,
    required this.onTap,
  });

  final String? text;
  final FilterType filter;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 6.sp,
          vertical: 6.sp,
        ),
        decoration: BoxDecoration(
          color: context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            color: context.textTheme.headlineLarge!.color!,
          ),
        ),
        child: Row(
          children: [
            10.widthSp,
            Text(
              text ?? filter.translate(context),
              style: Styles.poppins(
                fontSize: 14.sp,
                fontWeight: Styles.regular,
                color: text.isNotNullOrEmpty
                    ? context.textTheme.displayLarge!.color
                    : context.textTheme.headlineLarge!.color,
                height: 1.2,
              ),
            ),
            6.widthSp,
            Icon(
              Icons.arrow_drop_down,
              size: 20.sp,
              color: context.textTheme.headlineLarge!.color,
            ),
            4.widthSp,
          ],
        ),
      ),
    );
  }
}
