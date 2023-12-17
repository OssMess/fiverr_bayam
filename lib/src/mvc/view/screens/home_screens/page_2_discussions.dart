import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class Page2Discussions extends StatefulWidget {
  const Page2Discussions({
    super.key,
    required this.userSession,
    required this.page,
  });

  final UserSession userSession;
  final int page;

  @override
  State<Page2Discussions> createState() => _Page2DiscussionsState();
}

class _Page2DiscussionsState extends State<Page2Discussions> {
  @override
  Widget build(BuildContext context) {
    widget.userSession.listDiscussions?.initData(callGet: widget.page == 1);
    return ChangeNotifierProvider.value(
      value: widget.userSession.listDiscussions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.messages,
                  style: Styles.poppins(
                    fontSize: 26.sp,
                    fontWeight: Styles.bold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.you_have_nb_new_messages(2),
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.regular,
                    color: context.textTheme.displayMedium!.color,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomRefreshIndicator(
              onRefresh: widget.userSession.listDiscussions!.refresh,
              child: Consumer<ListDiscussions?>(
                builder: (context, listDiscussions, _) {
                  if (listDiscussions == null || listDiscussions.isNull) {
                    return const CustomLoadingIndicator(
                      isSliver: false,
                    );
                  }
                  if (listDiscussions.isEmpty) {
                    return EmptyListView(
                      svgPath: 'assets/images/Empty-pana.svg',
                      title: AppLocalizations.of(context)!.empty_discussions,
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 32.sp),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: listDiscussions.length,
                    itemBuilder: (context, index) => DiscussionTile(
                      userSession: widget.userSession,
                      discussion: listDiscussions.elementAt(index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
