// TODO: translate

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../settings.dart';
import '../../../../tools.dart';
import '../../screens.dart';

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                  CustomElevatedContainer(
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
                        4.heightSp,
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24.sp,
                              backgroundColor:
                                  context.textTheme.headlineSmall!.color,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.ad.userPhotoUrl,
                              ),
                            ),
                            16.widthSp,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Xavier wills',
                                        style: Styles.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: Styles.semiBold,
                                          color: context
                                              .textTheme.displayLarge!.color,
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
                                      color: context
                                          .textTheme.displayMedium!.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            16.widthSp,
                            CustomFlatButton(
                              icon: AwesomeIcons.thumbs_up,
                              iconSize: 20.sp,
                              iconColor:
                                  context.textTheme.headlineMedium!.color,
                              color: context.textTheme.headlineSmall!.color,
                              border: null,
                            ),
                            16.widthSp,
                            CustomFlatButton(
                              icon: AwesomeIcons.flag_pennant,
                              iconSize: 20.sp,
                              iconColor: Styles.red,
                              color: context.textTheme.headlineSmall!.color,
                              border: null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
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
