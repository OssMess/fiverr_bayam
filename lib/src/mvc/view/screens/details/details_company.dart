import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class DetailsCompany extends StatefulWidget {
  const DetailsCompany({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  State<DetailsCompany> createState() => _DetailsCompanyState();
}

class _DetailsCompanyState extends State<DetailsCompany> {
  late PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(children: [
        CustomAppBarBackground(
          type: AppBarBackgroundType.shrink,
          appBarTitleWidget: const CustomAppBarLogo(),
          appBarLeading: AppBarActionButton(
            icon: context.backButtonIcon,
            onTap: context.pop,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  DetailsAlbumGallery(
                    flagUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Flag_of_Cameroon.png/640px-Flag_of_Cameroon.png',
                    photosUrl: [
                      widget.company.coverUrl,
                      widget.company.coverUrl,
                      widget.company.coverUrl,
                      widget.company.coverUrl,
                      widget.company.coverUrl,
                    ],
                    description:
                        'We are offering pesticide services for corn, wheat crops and many more.',
                    pageController: pageController,
                  ),
                  16.heightSp,
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 5,
                    effect: WormEffect(
                      activeDotColor: Styles.green[500]!,
                      dotColor: context.textTheme.headlineMedium!.color!,
                      dotHeight: 10.sp,
                      dotWidth: 10.sp,
                      spacing: 8.sp,
                    ),
                  ),
                  16.heightSp,
                  DetailsDescriptionBanner(
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vel urna quis velit semper malesuada non bibendum justo. Nunc feugiat orci vel ligula posuere, sed pellentesque ligula dictum. Nulla vulputate lorem augue molestie, nec hendrerit lorem tincidunt.',
                    address: '13-A Clements Road, NYC',
                    tags: [
                      AppLocalizations.of(context)!.top_rated,
                      AppLocalizations.of(context)!.climate_eco,
                      AppLocalizations.of(context)!.technology,
                    ],
                    likes: 43,
                    website: 'www.samak.com',
                    employees: 120,
                  ),
                  16.heightSp,
                  const DetailsCompanyBanner(
                    name: 'Samak Enterprises',
                    logoUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjCuB_T9XRgCcwrQi4u8_zhnVFoQcsIOGa6Q&usqp=CAU',
                  ),
                  (context.viewPadding.bottom + 20.sp).height,
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
