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
    required this.userSession,
    required this.userMin,
  });

  final UserSession userSession;
  final UserMin userMin;

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
                    photosUrl: widget.userMin.imageCompanyUrl ?? [],
                    description: widget.userMin.bio ?? '',
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
                    onLike: null,
                  ),
                  16.heightSp,
                  DetailsCompanyBanner(
                    userSession: widget.userSession,
                    userMin: widget.userMin,
                    isMine: widget.userMin.uid == widget.userSession.uid,
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
