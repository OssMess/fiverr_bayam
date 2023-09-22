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

class Page1Home extends StatelessWidget {
  const Page1Home({
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
                  title: AppLocalizations.of(context)!.popular_companies,
                  trailing: '${AppLocalizations.of(context)!.show_all} >',
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
                      itemBuilder: (context, index) => CompanyPopularTile(
                        company: ListData.popularCompanies[index],
                      ),
                      separatorBuilder: (context, index) => 12.widthSp,
                    ),
                  ),
                ),
                8.sliverSp,
                SliverHeaderTile(
                  title: AppLocalizations.of(context)!.premium_ads,
                  trailing: '${AppLocalizations.of(context)!.show_all} >',
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
                      ),
                      separatorBuilder: (context, index) => 12.widthSp,
                    ),
                  ),
                ),
                8.sliverSp,
                SliverHeaderTile(
                  title: AppLocalizations.of(context)!.ads,
                  trailing: '${AppLocalizations.of(context)!.show_all} >',
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
  }
}

class SliverHeaderTile extends StatelessWidget {
  const SliverHeaderTile({
    super.key,
    required this.title,
    this.trailing,
    this.onTapTrailing,
  }) : assert(
            (trailing == null && onTapTrailing == null) || (trailing != null));

  final String title;
  final String? trailing;
  final void Function()? onTapTrailing;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Styles.poppins(
                  fontSize: 16.sp,
                  fontWeight: Styles.semiBold,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ),
            if (trailing != null)
              InkResponse(
                onTap: onTapTrailing,
                child: Text(
                  trailing!,
                  style: Styles.poppins(
                    fontSize: 10.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayMedium!.color,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
