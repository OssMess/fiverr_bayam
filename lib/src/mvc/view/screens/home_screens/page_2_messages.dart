import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class Page2Messages extends StatefulWidget {
  const Page2Messages({
    super.key,
    required this.userSession,
    required this.page,
  });

  final UserSession userSession;
  final int page;

  @override
  State<Page2Messages> createState() => _Page2MessagesState();
}

class _Page2MessagesState extends State<Page2Messages> {
  ListDiscussions listDiscussions = ListDiscussions();
  @override
  Widget build(BuildContext context) {
    listDiscussions.initData(callGet: widget.page == 1);
    return Column(
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
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 32.sp),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: ListData.chats.length,
              itemBuilder: (context, index) =>
                  ChatTile(chat: ListData.chats[index]),
            ),
          ),
        ),
      ],
    );
  }
}
