import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class FAQSupport extends StatefulWidget {
  const FAQSupport({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<FAQSupport> createState() => _FAQSupportState();
}

class _FAQSupportState extends State<FAQSupport> {
  int faqTypeIndex = 0;
  // FAQType faqType = FAQType.payment;
  FAQ? faq;
  late List<FAQ> listFAQ;

  @override
  void initState() {
    listFAQ = ListFAQ.map[faqTypeIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !showFAQView,
      onPopInvoked: (poped) {
        if (!poped) {
          setState(() {
            faq = null;
          });
        }
      },
      child: Scaffold(
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
                onTap: () {
                  if (pickFAQView) {
                    context.pop();
                  } else {
                    setState(() {
                      faq = null;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: showFAQView
                    ? EdgeInsets.symmetric(horizontal: 16.sp)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pickFAQView) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: Text(
                          AppLocalizations.of(context)!.faq,
                          style: Styles.poppins(
                            fontSize: 18.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                      ),
                      8.heightSp,
                      SizedBox(
                        height: 50.sp,
                        width: double.infinity,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 8.sp,
                          ),
                          itemBuilder: (context, index) => CustomChip<int>(
                            value: index,
                            title: ListFAQ.getFAQTypeFromIndex(index)
                                .translate(context),
                            groupValue: faqTypeIndex,
                            onChange: (index) => setState(
                              () {
                                faqTypeIndex = index;
                                listFAQ = ListFAQ.map[index];
                              },
                            ),
                          ),
                          separatorBuilder: (context, index) => 12.widthSp,
                          itemCount: ListFAQ.map.length,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.all(
                            16.sp,
                          ).copyWith(
                            bottom: context.viewPadding.bottom + 90.sp,
                          ),
                          itemBuilder: (context, index) => FAQListTile(
                            faq: ListFAQ.map[faqTypeIndex][index],
                            ontTap: (value) => setState(() {
                              faq = value;
                            }),
                          ),
                          separatorBuilder: (context, index) => CustomDivider(
                            height: 32.sp,
                          ),
                          itemCount: listFAQ.length,
                        ),
                      ),
                      Center(
                        child: CustomElevatedButton(
                          label: AppLocalizations.of(context)!.contact_support,
                          onPressed: () => context.push(
                            widget: ContactSupport(
                              userSession: widget.userSession,
                            ),
                          ),
                        ),
                      ),
                      0.15.sh.height,
                    ],
                    if (showFAQView) ...[
                      Text(
                        faq!.question,
                        style: Styles.poppins(
                          fontSize: 18.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      CustomDivider(
                        height: 48.sp,
                      ),
                      Expanded(
                        child: Text(
                          faq!.answer,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.medium,
                            color: context.textTheme.displayMedium!.color,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(32.sp),
                            margin: EdgeInsets.symmetric(horizontal: 32.sp),
                            decoration: BoxDecoration(
                              color: context.textTheme.headlineSmall!.color,
                              borderRadius: BorderRadius.circular(14.sp),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .was_the_answer_helpful,
                                  style: Styles.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: Styles.semiBold,
                                    color:
                                        context.textTheme.displayLarge!.color,
                                  ),
                                ),
                                32.heightSp,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (
                                      AwesomeIcons.thumbs_up,
                                      Styles.green,
                                      () {},
                                    ),
                                    (
                                      AwesomeIcons.thumbs_down,
                                      Styles.red,
                                      () {},
                                    ),
                                  ]
                                      .map(
                                        (button) => InkResponse(
                                          onTap: button.$3,
                                          child: Container(
                                            padding: EdgeInsets.all(16.sp),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8.sp),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: button.$2,
                                            ),
                                            child: Icon(
                                              button.$1,
                                              size: 30.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      0.15.sh.height,
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get pickFAQView => faq == null;

  bool get showFAQView => faq != null;
}

class FAQListTile extends StatelessWidget {
  const FAQListTile({
    super.key,
    required this.faq,
    required this.ontTap,
  });

  final FAQ faq;
  final void Function(FAQ) ontTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => ontTap(faq),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              faq.question,
              style: Styles.poppins(
                fontSize: 16.sp,
                fontWeight: Styles.medium,
                color: context.textTheme.displayMedium!.color,
              ),
            ),
          ),
          12.widthSp,
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 24.sp,
            color: context.textTheme.displayMedium!.color,
          ),
        ],
      ),
    );
  }
}
