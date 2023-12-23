import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    required this.userSession,
    required this.ad,
  });

  final UserSession userSession;
  final Ad ad;

  @override
  State<DetailsAd> createState() => _DetailsAdState();
}

class _DetailsAdState extends State<DetailsAd> {
  late PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    if (!widget.ad.isMine) {
      widget.ad.markVisited(widget.userSession);
    }
  }

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
      body: ChangeNotifierProvider.value(
        value: widget.ad,
        child: Consumer<Ad>(
          builder: (context, ad, _) {
            return Column(
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
                            photosUrl: ad.imagesUrl,
                            description: ad.content,
                            adType: ad.type,
                            pageController: pageController,
                          ),
                          16.heightSp,
                          SmoothPageIndicator(
                            controller: pageController,
                            count: ad.imagesCount,
                            effect: WormEffect(
                              activeDotColor: Styles.green[500]!,
                              dotColor:
                                  context.textTheme.headlineMedium!.color!,
                              dotHeight: 10.sp,
                              dotWidth: 10.sp,
                              spacing: 8.sp,
                            ),
                          ),
                          if (ad.author.isPerson) ...[
                            16.heightSp,
                            DetailsCreatorBanner(
                              name: ad.author.displayName,
                              photoUrl: ad.author.imageUrl,
                              service:
                                  AppLocalizations.of(context)!.agriculture,
                            ),
                          ],
                          16.heightSp,
                          DetailsDescriptionBanner(
                            description: ad.content,
                            address: ad.location,
                            tags: ad.tags.map((e) => e.name).toList(),
                            likes: ad.likes,
                            date: DateFormat('dd-MM-yy').format(ad.createdAt),
                            onLike: () => ad.like(widget.userSession),
                          ),
                          if (ad.author.isCompany) ...[
                            16.heightSp,
                            DetailsCompanyBanner(
                              name: ad.author.displayName,
                              logoUrl: ad.author.imageUrl,
                              isMine: ad.isMine,
                            ),
                          ],
                          (context.viewPadding.bottom + 20.sp).height,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
