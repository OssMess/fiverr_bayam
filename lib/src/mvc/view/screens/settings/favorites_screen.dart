import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({
    super.key,
    required this.userSession,
  });
  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: CustomRefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    sliver: SliverList.separated(
                      itemCount: ListData.ads.length,
                      separatorBuilder: (context, index) => 12.heightSp,
                      itemBuilder: (context, index) => AdTile(
                        userSession: userSession,
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
      ),
    );
  }
}
