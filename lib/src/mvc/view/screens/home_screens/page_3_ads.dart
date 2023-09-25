import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/change_notifiers.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../screens.dart';
import '../../tiles.dart';

class Page3Ads extends StatefulWidget {
  const Page3Ads({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<Page3Ads> createState() => _Page3AdsState();
}

class _Page3AdsState extends State<Page3Ads> {
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
