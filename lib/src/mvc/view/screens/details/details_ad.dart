import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class DetailsAd extends StatefulWidget {
  const DetailsAd({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  State<DetailsAd> createState() => _DetailsAdState();
}

class _DetailsAdState extends State<DetailsAd> {
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
      body: Column(
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    DetailsAlbumGallery(
                      photosUrl: const [
                        // widget.ad.coverUrl ??
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGdwTxs6lW7B5VgaAceI0p2XfmabWvee-MHlZ_ODsRB3VvM07vzNA3RVmu0OVYrdAHCYU&usqp=CAU'
                      ],
                      description: widget.ad.content,
                      adType: widget.ad.type,
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
                    if (widget.ad.author.isPerson) ...[
                      16.heightSp,
                      DetailsCreatorBanner(
                        name: widget.ad.author.fullName,
                        photoUrl: widget.ad.author.photoUrl,
                        service: AppLocalizations.of(context)!.agriculture,
                      ),
                    ],
                    16.heightSp,
                    DetailsDescriptionBanner(
                      description: widget.ad.content,
                      address: widget.ad.location,
                      tags: widget.ad.tags.map((e) => e.name).toList(),
                      likes: widget.ad.likes,
                      date: DateFormat('dd-MM-yy').format(widget.ad.createdAt),
                    ),
                    if (widget.ad.author.isCompany) ...[
                      16.heightSp,
                      DetailsCompanyBanner(
                        name: widget.ad.author.fullName,
                        logoUrl: widget.ad.author.photoUrl,
                      ),
                    ],
                    (context.viewPadding.bottom + 20.sp).height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
