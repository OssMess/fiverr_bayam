import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
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
  NotifierViewMode notifierViewMode = NotifierViewMode();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifierViewMode,
        builder: (context, _, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainSearchTextFormField(notifierViewMode: notifierViewMode),
              if (notifierViewMode.isNotInPageNormal)
                SearchScreen(notifierViewMode: notifierViewMode),
              if (notifierViewMode.isInPageNormal)
                Expanded(
                  child: CustomRefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        16.sliverSp,
                        SliverHeaderTile(
                          title:
                              AppLocalizations.of(context)!.popular_companies,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () {},
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 170.sp,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: ListData.popularCompanies.length,
                              itemBuilder: (context, index) => CompanyTile(
                                company: ListData.popularCompanies[index],
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                        8.sliverSp,
                        SliverHeaderTile(
                          title: AppLocalizations.of(context)!.premium_ads,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () {},
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 265.sp,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: ListData.premiumAds.length,
                              itemBuilder: (context, index) => AdTile(
                                ad: ListData.premiumAds[index],
                                expanded: false,
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                        8.sliverSp,
                        SliverHeaderTile(
                          title: AppLocalizations.of(context)!.ads,
                          trailing:
                              '${AppLocalizations.of(context)!.show_all} >',
                          onTapTrailing: () {},
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            height: 265.sp,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.sp,
                                vertical: 12.sp,
                              ),
                              itemCount: ListData.ads.length,
                              itemBuilder: (context, index) => AdTile(
                                ad: ListData.ads[index],
                                expanded: false,
                              ),
                              separatorBuilder: (context, index) => 12.widthSp,
                            ),
                          ),
                        ),
                        (context.viewPadding.bottom + 20.sp).sliver,
                      ],
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
