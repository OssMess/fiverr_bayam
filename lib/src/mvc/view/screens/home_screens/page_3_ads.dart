//TODO translate
import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class Page3Ads extends StatelessWidget {
  const Page3Ads({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: CustomTextFormField(
            hintText: AppLocalizations.of(context)!.what_are_you_looking_for,
            prefixIcon: AwesomeIcons.magnifying_glass,
            fillColor: context.textTheme.headlineSmall!.color,
          ),
        ),
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
                  trailing: '${AppLocalizations.of(context)!.nb_results(43)} >',
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
  }
}
