import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      body: ChangeNotifierProvider.value(
        value: widget.userMin,
        child: Consumer<UserMin>(
          builder: (context, userMin, _) {
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
                          if ((userMin.imageCompanyUrl ?? []).isNotEmpty) ...[
                            DetailsAlbumGallery(
                              photosUrl: userMin.imageCompanyUrl ?? [],
                              description: userMin.bio ?? '',
                              pageController: pageController,
                            ),
                            16.heightSp,
                            SmoothPageIndicator(
                              controller: pageController,
                              count: userMin.imageCompanyUrl!.length,
                              effect: WormEffect(
                                activeDotColor: Styles.green[500]!,
                                dotColor:
                                    context.textTheme.headlineMedium!.color!,
                                dotHeight: 10.sp,
                                dotWidth: 10.sp,
                                spacing: 8.sp,
                              ),
                            ),
                            16.heightSp,
                          ],
                          DetailsDescriptionBanner(
                            description: userMin.bio,
                            address: userMin.streetAddress,
                            //FIXME add company tags
                            tags: null,
                            likes: userMin.countLiked ?? 0,
                            //FIXME website url
                            website: null,
                            //FIXME employees
                            employees: null,
                            onLike: () => userMin.likeCompany(
                              context,
                              widget.userSession,
                            ),
                          ),
                          16.heightSp,
                          DetailsCompanyBanner(
                            userSession: widget.userSession,
                            userMin: userMin,
                            isMine: userMin.uid == widget.userSession.uid,
                          ),
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
