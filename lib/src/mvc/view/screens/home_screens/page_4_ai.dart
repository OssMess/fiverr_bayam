//TODO translate
import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../tiles.dart';

class Page4AI extends StatelessWidget {
  const Page4AI({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48.sp,
              backgroundColor: Styles.green,
              child: CircleAvatar(
                radius: 45.sp,
                backgroundColor: context.textTheme.headlineSmall!.color,
                foregroundImage: const CachedNetworkImageProvider(
                  'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315305235-RCUO3EX7WIENHM8CG9U1/20210601_SLP2805-edit.jpg?format=1000w',
                ),
              ),
            ),
            12.heightSp,
            Text(
              'Babana',
              style: Styles.poppins(
                fontSize: 20.sp,
                fontWeight: Styles.bold,
                color: context.textTheme.displayLarge!.color,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.your_personal_ai_assitant,
              style: Styles.poppins(
                fontSize: 14.sp,
                fontWeight: Styles.regular,
                color: context.textTheme.displaySmall!.color,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            reverse: true,
            padding: EdgeInsets.all(16.sp),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: ListData.aiChat.length,
            separatorBuilder: (context, index) => 8.heightSp,
            itemBuilder: (context, index) => MessageTile(
              message: ListData.aiChat[index],
              lastMessage: index > 0 ? ListData.aiChat[index - 1] : null,
            ),
          ),
        ),
      ],
    );
  }
}
