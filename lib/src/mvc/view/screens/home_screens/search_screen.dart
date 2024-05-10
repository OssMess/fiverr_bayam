import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late ListCompaniesFilter listCompaniesFilter;
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
    listCompaniesFilter = ListCompaniesFilter(userSession: widget.userSession);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: listAdsFilter),
        ChangeNotifierProvider.value(value: listCompaniesFilter),
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
                    return CustomScrollView(
                      slivers: [
                        SliverList.list(
                          children: [
                            //search text form field
                            MainSearchTextFormField(
                              onSearch: (content) {
                                this.content = content;
                                callFilter();
                              },
                              notifierViewMode: notifierViewMode,
                            ),
                            16.heightSp,
                            //filters
                            ValueListenableBuilder(
                              valueListenable: notifierViewMode,
                              builder: (context, _, __) {
                                return Filters(
                                  content: content,
                                  country: country,
                                  region: region,
                                  type: type,
                                  searchTab: notifierViewMode.searchTab,
                                  onChange: onChangeAdFilter,
                                );
                              },
                            ),

                            /// Categories
                            if (notifierViewMode.isInPageNormal ||
                                notifierViewMode.isInPageResults) ...[
                              TabViewController(
                                notifierPersonViewMode: notifierViewMode,
                                tabController: tabController,
                                onChange: (page) {
                                  if (!notifierViewMode.isInPageResults) return;
                                  if (page == 0) {
                                    if (listAdsFilter.isNotNull) return;
                                    listAdsFilter.filter(
                                      content: content,
                                      country: country,
                                      region: region,
                                      type: type,
                                    );
                                  } else {
                                    if (listCompaniesFilter.isNotNull) return;
                                    listCompaniesFilter.filter(
                                      content: content,
                                      country: country,
                                      region: region,
                                    );
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                        if (notifierViewMode.isInPageNormal)
                          CategoryPicker(
                            tabController: tabController,
                            notifierViewMode: notifierViewMode,
                            onChange: callFilter,
                          ),

                        /// user in suggestions page
                        if (notifierViewMode.isInPageSuggestions) ...[
                          SliverList.list(
                            children: [
                              12.heightSp,
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .recent_searches,
                                    style: Styles.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: Styles.semiBold,
                                      color:
                                          context.textTheme.displayLarge!.color,
                                    ),
                                  ),
                                ),
                              ),
                              8.heightSp,
                            ],
                          ),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return SliverPadding(
                                padding: EdgeInsets.all(16.sp),
                                sliver: SliverList.separated(
                                  itemCount: HiveSearchHistory.list.length,
                                  itemBuilder: (context, index) =>
                                      SearchHistoryTile(
                                    searchHistory:
                                        HiveSearchHistory.list[index],
                                    onTap: () {
                                      onChangeAdFilter(
                                        content: HiveSearchHistory.list
                                            .elementAt(index)
                                            .categorySub
                                            .name,
                                      );
                                      // notifierViewMode.openPageResults();
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
                          NotificationListener<ScrollNotification>(
                            onNotification: listAdsFilter.onMaxScrollExtent,
                            child: AnimatedBuilder(
                              animation: tabController,
                              // child: SliverToBoxAdapter(child: SizedBox.shrink()),
                              builder: (context, child) {
                                if (notifierViewMode.isInTabProducts) {
                                  return Consumer<ListAdsFilter>(
                                    builder: (context, listAdsFilter, _) {
                                      if (listAdsFilter.isLoading) {
                                        return const CustomLoadingIndicator(
                                          isSliver: true,
                                        );
                                      }
                                      if (listAdsFilter.isEmpty) {
                                        return SliverToBoxAdapter(
                                          child: EmptyListView(
                                            title: AppLocalizations.of(context)!
                                                .empty_ads_filter,
                                            svgPath:
                                                'assets/images/Empty-pana.svg',
                                          ),
                                        );
                                      }
                                      return SliverPadding(
                                        padding: EdgeInsets.all(16.sp),
                                        sliver: SliverList.separated(
                                          itemCount: listAdsFilter.childCount,
                                          separatorBuilder: (context, index) =>
                                              12.heightSp,
                                          itemBuilder: (context, index) =>
                                              Builder(
                                            builder: (context) {
                                              if (index <
                                                  listAdsFilter.length) {
                                                return AdTile(
                                                  userSession:
                                                      widget.userSession,
                                                  ad: listAdsFilter
                                                      .elementAt(index),
                                                  expanded: true,
                                                  onTap: () {
                                                    HiveSearchHistory.save(
                                                      SearchHistory.fromAd(
                                                        listAdsFilter
                                                            .elementAt(index),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return CustomTrailingTile(
                                                  hasMore:
                                                      listAdsFilter.hasMore,
                                                  isLoading:
                                                      listAdsFilter.isLoading,
                                                  isNotNull:
                                                      listAdsFilter.isNotNull,
                                                  isSliver: false,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Consumer<ListCompaniesFilter>(
                                    builder: (context, listCompaniesFilter, _) {
                                      if (listCompaniesFilter.isLoading) {
                                        return const CustomLoadingIndicator(
                                          isSliver: true,
                                        );
                                      }
                                      if (listCompaniesFilter.isEmpty) {
                                        return SliverToBoxAdapter(
                                          child: EmptyListView(
                                            title: AppLocalizations.of(context)!
                                                .empty_companies_filter,
                                            svgPath:
                                                'assets/images/Empty-pana.svg',
                                          ),
                                        );
                                      }
                                      return SliverPadding(
                                        padding: EdgeInsets.all(16.sp),
                                        sliver: SliverList.separated(
                                          itemCount:
                                              listCompaniesFilter.childCount,
                                          separatorBuilder: (context, index) =>
                                              12.heightSp,
                                          itemBuilder: (context, index) =>
                                              Builder(
                                            builder: (context) {
                                              if (index <
                                                  listCompaniesFilter.length) {
                                                return CompanyTile(
                                                  userSession:
                                                      widget.userSession,
                                                  userMin: listCompaniesFilter
                                                      .elementAt(index),
                                                  isExpanded: true,
                                                );
                                              } else {
                                                return CustomTrailingTile(
                                                  hasMore: listCompaniesFilter
                                                      .hasMore,
                                                  isLoading: listCompaniesFilter
                                                      .isLoading,
                                                  isNotNull: listCompaniesFilter
                                                      .isNotNull,
                                                  isSliver: false,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void callFilter() {
    listAdsFilter.reset();
    listCompaniesFilter.reset();
    if (notifierViewMode.isInTabProducts) {
      listAdsFilter.filter(
        content: content,
        country: country,
        region: region,
        type: type,
      );
    } else {
      listCompaniesFilter.filter(
        content: content,
        country: country,
        region: region,
      );
    }
    notifierViewMode.openPageResults();
  }

  void onChangeAdFilter({
    String? content,
    String? country,
    String? region,
    AdType? type,
  }) {
    if (content.isNotNullOrEmpty) {
      this.content = content;
    }
    if (country.isNotNullOrEmpty) {
      this.country = country;
      this.region = null;
    }
    if (region.isNotNullOrEmpty) {
      this.region = region;
    }
    if (type != null) {
      this.type = type;
    }
    callFilter();
  }
}

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    super.key,
    required this.tabController,
    required this.notifierViewMode,
    required this.onChange,
  });

  final TabController tabController;
  final NotifierPersonViewMode notifierViewMode;
  final void Function() onChange;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
        return SliverPadding(
          padding: EdgeInsets.all(16.sp),
          sliver: SliverList.separated(
            itemCount: categories.length,
            itemBuilder: (context, index) => CategoryTile(
              category: categories.elementAt(index),
              onTap: () {
                notifierViewMode.openPageResults();
                onChange();
              },
            ),
            separatorBuilder: (context, index) => 12.heightSp,
          ),
        );
      },
    );
  }
}

class TabViewController extends StatelessWidget {
  const TabViewController({
    super.key,
    required this.notifierPersonViewMode,
    required this.tabController,
    required this.onChange,
  });

  final NotifierPersonViewMode notifierPersonViewMode;
  final TabController tabController;
  final void Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp).copyWith(
        top: 16.sp,
      ),
      child: CustomTabBar(
        controller: tabController,
        tabs: [
          AppLocalizations.of(context)!.products_and_services,
          AppLocalizations.of(context)!.companies,
        ],
        onTap: (tab) {
          onChange(tab);
          if (tab == 0) {
            notifierPersonViewMode.openTabProducts();
          } else {
            notifierPersonViewMode.openTabCompanies();
          }
        },
      ),
    );
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
        constraints: BoxConstraints(
          maxWidth: 125.w,
          minWidth: 60.w,
        ),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            10.widthSp,
            Expanded(
              child: Text(
                text ?? filter.translate(context),
                overflow: TextOverflow.ellipsis,
                style: Styles.poppins(
                  fontSize: 14.sp,
                  fontWeight: Styles.regular,
                  color: text.isNotNullOrEmpty
                      ? context.textTheme.displayLarge!.color
                      : context.textTheme.headlineLarge!.color,
                  height: 1.2,
                ),
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

class Filters extends StatelessWidget {
  const Filters({
    super.key,
    required this.content,
    required this.country,
    required this.region,
    required this.type,
    required this.searchTab,
    required this.onChange,
  });

  final String? content;
  final String? country;
  final String? region;
  final AdType? type;
  final SearchTab searchTab;
  final void Function({
    String? content,
    String? country,
    String? region,
    AdType? type,
  }) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: CountryCodePicker(
                    initialSelection: 'CM',
                    showCountryOnly: true,
                    enabled: true,
                    favorite: const ['+237'],
                    comparator: (a, b) => b.name!.compareTo(a.name!),
                    boxDecoration: BoxDecoration(
                      color: context.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    textStyle: Styles.poppins(
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayMedium!.color,
                      fontSize: 14.sp,
                      height: 1.2,
                    ),
                    onChanged: (code) {
                      onChange(
                        country: code.name,
                        region: null,
                      );
                    },
                    padding: EdgeInsets.zero,
                    flagWidth: 30.sp,
                  ),
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
                title: AppLocalizations.of(context)!.filter_by_region,
                hintText: AppLocalizations.of(context)!.filter_by_region,
                initialvalue: region,
                showPasteButton: false,
                onPick: (value) {
                  onChange(
                    region: value,
                  );
                },
              );
            },
          ),
          12.widthSp,
          if (searchTab == SearchTab.products)
            FilterCard(
              text: type?.translate(context),
              filter: FilterType.adtype,
              onTap: () {
                Dialogs.of(context).showSingleValuePickerDialog(
                  mainAxisSize: MainAxisSize.min,
                  title: AppLocalizations.of(context)!.filter_ads_by_type,
                  values: [
                    AppLocalizations.of(context)!.all,
                    AdType.rent.translate(context),
                    AdType.sell.translate(context),
                    AdType.want.translate(context),
                  ],
                  initialvalue: type?.translate(context) ??
                      AppLocalizations.of(context)!.all,
                  onPick: (value) {
                    onChange(
                      type: {
                        AdType.rent.translate(context): AdType.rent,
                        AdType.sell.translate(context): AdType.sell,
                        AdType.want.translate(context): AdType.want,
                        AppLocalizations.of(context)!.all: null,
                      }[value],
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
