//TODO translate
import 'package:bayam/src/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class Page2Messages extends StatelessWidget {
  const Page2Messages({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    // return const CustomScrollView();
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
