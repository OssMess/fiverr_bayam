import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: CustomTextFormField(
            hintText: 'What are you looking for?',
            prefixIcon: AwesomeIcons.magnifying_glass,
            fillColor: context.textTheme.headlineSmall!.color,
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              16.sliverSp,
              SliverHeaderTile(
                title: 'Popular Companies',
                trailing: 'Show all >',
                onTapTrailing: () {},
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 175.sp,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 16.sp,
                    ),
                    itemCount: ListData.popularCompanies.length,
                    itemBuilder: (context, index) => CompanyPopularTile(
                      name: ListData.popularCompanies[index]['name']!,
                      title: ListData.popularCompanies[index]['title']!,
                      logoUrl: ListData.popularCompanies[index]['logoUrl']!,
                      coverUrl: ListData.popularCompanies[index]['coverUrl']!,
                      isVerified: ListData.popularCompanies[index]
                          ['isVerified']!,
                    ),
                    separatorBuilder: (context, index) => 12.widthSp,
                  ),
                ),
              ),
              8.sliverSp,
              SliverHeaderTile(
                title: 'Premium Ads',
                trailing: 'Show all >',
                onTapTrailing: () {},
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 270.sp,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 16.sp,
                    ),
                    itemCount: ListData.popularCompanies.length,
                    itemBuilder: (context, index) => AdPremiumTile(
                      name: ListData.popularCompanies[index]['name']!,
                      title: ListData.popularCompanies[index]['title']!,
                      logoUrl: ListData.popularCompanies[index]['logoUrl']!,
                      coverUrl: ListData.popularCompanies[index]['coverUrl']!,
                      isVerified: ListData.popularCompanies[index]
                          ['isVerified']!,
                      adType: ListData.popularCompanies[index]['adType']!,
                    ),
                    separatorBuilder: (context, index) => 12.widthSp,
                  ),
                ),
              ),
              8.sliverSp,
              SliverHeaderTile(
                title: 'Ads',
                trailing: 'Show all >',
                onTapTrailing: () {},
              ),
              16.sliverSp,
              //TODO
              (context.viewPadding.bottom + 20.sp).sliver,
            ],
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
