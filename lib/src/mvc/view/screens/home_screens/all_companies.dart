import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../tiles.dart';

class AllCompanies extends StatelessWidget {
  const AllCompanies({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userSession.listCompaniesPopular,
      child: Consumer<ListCompaniesPopular>(
        builder: (context, listCompaniesPopular, _) {
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
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: SettingsHeaderSubtitle(
                    title: AppLocalizations.of(context)!.popular_companies,
                  ),
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: listCompaniesPopular.onMaxScrollExtent,
                    child: CustomRefreshIndicator(
                      onRefresh: listCompaniesPopular.refresh,
                      child: Builder(
                        builder: (context) {
                          if (listCompaniesPopular.isLoading) {
                            return const CustomLoadingIndicator(
                              isSliver: false,
                            );
                          }
                          if (listCompaniesPopular.isEmpty) {
                            return EmptyListView(
                              svgPath: 'assets/images/Empty-pana.svg',
                              title: AppLocalizations.of(context)!.empty_ads,
                            );
                          }
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 16.sp)
                                .copyWith(
                              bottom: context.viewPadding.bottom,
                            ),
                            itemCount: listCompaniesPopular.childCount,
                            separatorBuilder: (context, index) => 16.heightSp,
                            itemBuilder: (_, index) {
                              if (index < listCompaniesPopular.length) {
                                return CompanyTile(
                                  userSession: userSession,
                                  userMin:
                                      listCompaniesPopular.elementAt(index),
                                  isExpanded: true,
                                );
                              } else {
                                return CustomTrailingTile(
                                  isNotNull: listCompaniesPopular.isNotNull,
                                  isLoading: listCompaniesPopular.isLoading,
                                  hasMore: listCompaniesPopular.hasMore,
                                  isSliver: false,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
