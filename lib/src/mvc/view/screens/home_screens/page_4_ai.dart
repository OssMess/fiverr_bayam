//TODO translate
import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../tiles.dart';

class Page4AI extends StatefulWidget {
  const Page4AI({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<Page4AI> createState() => _Page4AIState();
}

class _Page4AIState extends State<Page4AI> {
  bool viewTextFormField = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        reverse: true,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16.sp),
            sliver: SliverList.separated(
              itemCount: ListData.aiChat.length + 1,
              separatorBuilder: (context, index) => 8.heightSp,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: context.textTheme.headlineSmall!.color,
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          label:
                              AppLocalizations.of(context)!.ai_how_bayam_work,
                          fontSize: 14.sp,
                          elevation: 0,
                          onPressed: () {},
                        ),
                        12.heightSp,
                        CustomElevatedButton(
                          label: AppLocalizations.of(context)!
                              .ai_import_my_contacts,
                          fontSize: 14.sp,
                          elevation: 0,
                          onPressed: () {},
                        ),
                        12.heightSp,
                        StatefulBuilder(
                          builder: (context, setState) {
                            if (viewTextFormField) {
                              //TODO focusnode
                              return CustomTextFormField(
                                focusNode: focusNode,
                                fillColor: context.scaffoldBackgroundColor,
                                hintText: AppLocalizations.of(context)!
                                    .ai_type_your_message,
                                suffixIcon: AwesomeIcons.paper_plane_top,
                                height: 50.sp,
                                suffixOnTap: () =>
                                    onSendMessage(setState: setState),
                                onEditingComplete: () =>
                                    onSendMessage(setState: setState),
                              );
                            } else {
                              return CustomElevatedButton(
                                label: AppLocalizations.of(context)!
                                    .ai_type_your_message,
                                color: context.scaffoldBackgroundColor,
                                fontColor:
                                    context.textTheme.headlineLarge!.color,
                                fontSize: 14.sp,
                                elevation: 0,
                                onPressed: () {
                                  setState(() {
                                    viewTextFormField = true;
                                  });
                                  focusNode.requestFocus();
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return MessageTile(
                    message: ListData.aiChat.elementAt(index - 1),
                    lastMessage: index > 1 ? ListData.aiChat[index - 2] : null,
                  );
                }
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
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
                40.heightSp,
              ],
            ),
          ),
        ],
      ),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         CircleAvatar(
    //           radius: 48.sp,
    //           backgroundColor: Styles.green,
    //           child: CircleAvatar(
    //             radius: 45.sp,
    //             backgroundColor: context.textTheme.headlineSmall!.color,
    //             foregroundImage: const CachedNetworkImageProvider(
    //               'https://images.squarespace-cdn.com/content/v1/51ef4493e4b0561c90fa76d6/1667315305235-RCUO3EX7WIENHM8CG9U1/20210601_SLP2805-edit.jpg?format=1000w',
    //             ),
    //           ),
    //         ),
    //         12.heightSp,
    //         Text(
    //           'Babana',
    //           style: Styles.poppins(
    //             fontSize: 20.sp,
    //             fontWeight: Styles.bold,
    //             color: context.textTheme.displayLarge!.color,
    //           ),
    //         ),
    //         Text(
    //           AppLocalizations.of(context)!.your_personal_ai_assitant,
    //           style: Styles.poppins(
    //             fontSize: 14.sp,
    //             fontWeight: Styles.regular,
    //             color: context.textTheme.displaySmall!.color,
    //           ),
    //         ),
    //       ],
    //     ),
    //     Expanded(
    //       child: ListView.separated(
    //         reverse: true,
    //         padding: EdgeInsets.all(16.sp),
    //         physics: const AlwaysScrollableScrollPhysics(),
    //         itemCount: ListData.aiChat.length,
    //         separatorBuilder: (context, index) => 8.heightSp,
    //         itemBuilder: (context, index) => MessageTile(
    //           message: ListData.aiChat[index],
    //           lastMessage: index > 0 ? ListData.aiChat[index - 1] : null,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Future<void> onSendMessage({
    required void Function(void Function()) setState,
  }) async {
    setState(() {
      viewTextFormField = false;
    });
  }
}
