import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              onRefresh: userSession.listAdsFavorites!.refresh,
              child: CustomScrollView(
                slivers: [
                  ChangeNotifierProvider.value(
                    value: userSession.listAdsFavorites,
                    child: Consumer<ListAdsFavorites>(
                      builder: (context, listAdsFavorites, _) {
                        listAdsFavorites.initData(
                          callGet: true,
                        );
                        if (listAdsFavorites.isNull) {
                          return const CustomLoadingIndicator(
                            isSliver: true,
                          );
                        }
                        if (listAdsFavorites.isEmpty) {
                          return SliverToBoxAdapter(
                            child: EmptyListView(
                              title: AppLocalizations.of(context)!
                                  .favorites_ads_empty,
                              svgPath: 'assets/images/Empty-pana.svg',
                            ),
                          );
                        }
                        return SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.sp),
                          sliver: SliverList.separated(
                            itemCount: listAdsFavorites.childCount,
                            separatorBuilder: (context, index) => 12.heightSp,
                            itemBuilder: (_, index) {
                              if (index < listAdsFavorites.length) {
                                return AdTile(
                                  userSession: userSession,
                                  ad: listAdsFavorites.elementAt(index),
                                  expanded: true,
                                );
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listAdsFavorites.isNotNull,
                                  isLoading: listAdsFavorites.isLoading,
                                  hasMore: listAdsFavorites.hasMore,
                                  isSliver: false,
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  70.sliverSp,
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
