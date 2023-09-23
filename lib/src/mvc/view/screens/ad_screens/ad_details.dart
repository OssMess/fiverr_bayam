// TODO: translate

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class AdDetails extends StatefulWidget {
  const AdDetails({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  State<AdDetails> createState() => _AdDetailsState();
}

class _AdDetailsState extends State<AdDetails> {
  late PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  AdGallery(
                    ad: widget.ad,
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
                  AdCreatorInformation(ad: widget.ad),
                  16.heightSp,
                  AdDescriptionBanner(ad: widget.ad),
                  16.heightSp,
                  AdCompanyBanner(widget: widget),
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

class AdCompanyBanner extends StatelessWidget {
  const AdCompanyBanner({
    super.key,
    required this.widget,
  });

  final AdDetails widget;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Row(
        children: [
          Container(
            height: 65.sp,
            width: 65.sp,
            padding: EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.textTheme.headlineMedium!.color!,
                width: 1.sp,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: context.textTheme.headlineSmall!.color,
              backgroundImage: CachedNetworkImageProvider(
                widget.ad.logoUrl,
              ),
            ),
          ),
          16.widthSp,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service by',
                  style: Styles.poppins(
                    fontSize: 13.sp,
                    fontWeight: Styles.regular,
                    color: context.textTheme.displayMedium!.color,
                  ),
                ),
                Text(
                  'Samak Enterprises',
                  overflow: TextOverflow.ellipsis,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
              ],
            ),
          ),
          16.widthSp,
          IconButton(
            onPressed: () {},
            icon: Icon(
              AwesomeIcons.chat_bold,
              color: Styles.green,
              size: 24.sp,
            ),
          )
        ],
      ),
    );
  }
}

class AdDescriptionBanner extends StatelessWidget {
  const AdDescriptionBanner({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Description',
            style: Styles.poppins(
              fontSize: 12.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Text(
            ad.description,
            style: Styles.poppins(
              fontSize: 11.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            children: [
              Icon(
                AwesomeIcons.location_dot_outlined,
                size: 18.sp,
                color: Styles.green,
              ),
              8.widthSp,
              Text(
                'Clements Road, NYC',
                style: Styles.poppins(
                  fontSize: 11.sp,
                  fontWeight: Styles.semiBold,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ],
          ),
          8.heightSp,
          Row(
            children: [
              Icon(
                AwesomeIcons.calendar_clock_outlined,
                size: 18.sp,
                color: Styles.green,
              ),
              16.widthSp,
              Text(
                '13-03-23',
                style: Styles.poppins(
                  fontSize: 11.sp,
                  fontWeight: Styles.semiBold,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ],
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 8.sp,
                  spacing: 8.sp,
                  children: [
                    'Climate/Eco-Friendly',
                    'Top Rated',
                    'Technology',
                  ]
                      .map(
                        (text) => CustomFlatButton(
                          color: Styles.green[50],
                          child: Text(
                            text,
                            style: Styles.poppins(
                              fontSize: 14.sp,
                              fontWeight: Styles.medium,
                              color: Styles.green,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          CustomDivider(
            height: 24.sp,
          ),
          Row(
            children: [
              CustomFlatButton(
                child: Row(
                  children: [
                    Icon(
                      AwesomeIcons.heart,
                      color: Styles.green,
                      size: 20.sp,
                    ),
                    8.widthSp,
                    Text(
                      '43 likes',
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                  ],
                ),
              ),
              16.widthSp,
              const CustomFlatButton(
                icon: AwesomeIcons.flag_pennant,
                iconColor: Styles.red,
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.share_from_square,
                iconColor: Styles.green,
                color: context.scaffoldBackgroundColor,
                addBorder: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdCreatorInformation extends StatelessWidget {
  const AdCreatorInformation({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creator Information',
            style: Styles.poppins(
              fontSize: 12.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
          8.heightSp,
          Row(
            children: [
              CircleAvatar(
                radius: 24.sp,
                backgroundColor: context.textTheme.headlineSmall!.color,
                backgroundImage: CachedNetworkImageProvider(
                  ad.userPhotoUrl,
                ),
              ),
              16.widthSp,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Xavier wills',
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        8.widthSp,
                        Icon(
                          AwesomeIcons.badge_check,
                          size: 16.sp,
                          color: Styles.blue,
                        ),
                      ],
                    ),
                    Text(
                      'Agriculture',
                      style: Styles.poppins(
                        fontSize: 11.sp,
                        fontWeight: Styles.regular,
                        color: context.textTheme.displayMedium!.color,
                      ),
                    ),
                  ],
                ),
              ),
              16.widthSp,
              CustomFlatButton(
                icon: AwesomeIcons.thumbs_up,
                iconColor: context.textTheme.headlineMedium!.color,
              ),
              16.widthSp,
              const CustomFlatButton(
                icon: AwesomeIcons.flag_pennant,
                iconColor: Styles.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdGallery extends StatelessWidget {
  const AdGallery({
    super.key,
    required this.ad,
    required this.pageController,
  });

  final Ad ad;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.sp),
          child: SizedBox(
            width: double.infinity,
            height: 0.3.sh,
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, index) => CachedNetworkImage(
                imageUrl: ad.coverUrl,
                fit: BoxFit.cover,
                color: context.textTheme.headlineSmall!.color,
                progressIndicatorBuilder: (context, url, progress) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: Styles.green,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: context.textTheme.headlineSmall!.color,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.sp,
                        vertical: 6.sp,
                      ),
                      decoration: BoxDecoration(
                        color: ad.adType.toBackgroundColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        ad.adType.toTitle(context),
                        style: Styles.poppins(
                          fontSize: 14.sp,
                          fontWeight: Styles.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: context.textTheme.headlineSmall!.color,
                      backgroundImage: const CachedNetworkImageProvider(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Flag_of_Cameroon.png/640px-Flag_of_Cameroon.png',
                      ),
                    ),
                  ],
                ),
                Text(
                  ad.description,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
