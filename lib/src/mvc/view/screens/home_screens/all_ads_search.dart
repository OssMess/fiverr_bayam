import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class AllAdsSearch extends StatefulWidget {
  const AllAdsSearch({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<AllAdsSearch> createState() => _AllAdsSearchState();
}

class _AllAdsSearchState extends State<AllAdsSearch> {
  TextEditingController controller = TextEditingController();
  late ListAdsSearch listAdsSearch;

  @override
  void initState() {
    super.initState();
    listAdsSearch = ListAdsSearch(userSession: widget.userSession);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: listAdsSearch,
      child: Consumer<ListAdsSearch>(
        builder: (context, listAdsSearch, _) {
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
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: CustomTextFormField(
                    controller: controller,
                    hintText:
                        AppLocalizations.of(context)!.what_are_you_looking_for,
                    prefixIcon: AwesomeIcons.magnifying_glass,
                    fillColor: context.textTheme.headlineSmall!.color,
                    onEditingComplete: () {
                      listAdsSearch.getSearch(search: controller.text);
                    },
                    textInputAction: TextInputAction.search,
                    suffix: SizedBox(
                      height: 55.sp,
                    ),
                    height: 55.sp,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(16.sp),
                //   child: SettingsHeaderSubtitle(
                //     title: AppLocalizations.of(context)!.ads,
                //   ),
                // ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (listAdsSearch.isLoading) {
                        return const CustomLoadingIndicator(
                          isSliver: false,
                          margin: EdgeInsets.zero,
                        );
                      }
                      if (listAdsSearch.isEmpty && listAdsSearch.isNull) {
                        return EmptyListView(
                          svgPath: 'assets/images/Empty-pana.svg',
                          title: AppLocalizations.of(context)!.ads_search,
                        );
                      }
                      if (listAdsSearch.isEmpty) {
                        return EmptyListView(
                          svgPath: 'assets/images/Empty-pana.svg',
                          title: AppLocalizations.of(context)!.empty_ads_search,
                        );
                      }
                      return ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.sp).copyWith(
                          bottom: context.viewPadding.bottom,
                          top: 16.sp,
                        ),
                        itemCount: listAdsSearch.length,
                        separatorBuilder: (context, index) => 16.heightSp,
                        itemBuilder: (_, index) {
                          return AdTile(
                            userSession: widget.userSession,
                            ad: listAdsSearch.elementAt(index),
                            expanded: true,
                          );
                        },
                      );
                    },
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
