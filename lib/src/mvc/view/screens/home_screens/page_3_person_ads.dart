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

class Page3PersonAds extends StatefulWidget {
  const Page3PersonAds({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<Page3PersonAds> createState() => _Page3PersonAdsState();
}

class _Page3PersonAdsState extends State<Page3PersonAds> {
  NotifierViewMode notifierViewMode = NotifierViewMode();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: notifierViewMode,
        builder: (context, _, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainSearchTextFormField(
                notifierViewMode: notifierViewMode,
              ),
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
                          title: AppLocalizations.of(context)!.ads,
                          trailing:
                              '${AppLocalizations.of(context)!.nb_results(43)} >',
                          onTapTrailing: () {},
                        ),
                        16.sliverSp,
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          sliver: SliverList.separated(
                            itemCount: ListData.ads.length,
                            separatorBuilder: (context, index) => 12.heightSp,
                            itemBuilder: (context, index) => AdTile(
                              ad: ListData.ads[index],
                              expanded: true,
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
