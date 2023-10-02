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
import '../../screens.dart';
import '../../tiles.dart';

class Page3CompanyAds extends StatelessWidget {
  const Page3CompanyAds({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return Consumer<ValueNotifier<AdsViewPage>>(
      builder: (context, viewPage, _) {
        bool promotedAds = viewPage.value == AdsViewPage.promotedAds;
        return CustomRefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
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
              SliverPadding(
                padding: EdgeInsets.all(16.sp),
                sliver: SliverToBoxAdapter(
                  child: CustomElevatedButton(
                    onPressed: () => context.push(
                        widget: const CreateAd(
                      ad: null,
                    )),
                    label: AppLocalizations.of(context)!.create_ad,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                sliver: SliverList.separated(
                  itemCount: ListData.ads.length,
                  separatorBuilder: (context, index) => 12.heightSp,
                  itemBuilder: (_, index) => AdTile(
                    ad: ListData.ads[index],
                    expanded: true,
                    showDates: promotedAds,
                    onTapOptions: () => onTapAdOptions(
                      context,
                      ListData.ads[index],
                    ),
                  ),
                ),
              ),
              if (!promotedAds) 70.sliverSp,
              (context.viewPadding.bottom + 20.sp).sliver,
            ],
          ),
        );
      },
    );
  }

  void onTapAdOptions(BuildContext context, Ad ad) {
    Dialogs.of(context).showDialogAdsOptions(ad);
  }
}
