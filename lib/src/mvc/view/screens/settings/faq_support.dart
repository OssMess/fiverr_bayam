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
  const FAQSupport({super.key});

  @override
  State<FAQSupport> createState() => _FAQSupportState();
}

class _FAQSupportState extends State<FAQSupport> {
  int faqTypeIndex = 0;
  FAQType faqType = FAQType.payment;
  FAQ? faq;
  late List<FAQ> listFAQ;

  @override
  void initState() {
    listFAQ = ListFAQ.getListFAQ(faqType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (showFAQView) {
          setState(() {
            faq = null;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: pickFAQView
            ? CustomElevatedButton(
                label: AppLocalizations.of(context)!.contact_support,
                onPressed: () => context.push(widget: const ContactSupport()),
              )
            : Column(
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
                          AppLocalizations.of(context)!.was_the_answer_helpful,
                          style: Styles.poppins(
                            fontSize: 16.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.sp),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                          itemBuilder: (context, index) => FAQTypeChip(
                            index: index,
                            isSelected: index == faqTypeIndex,
                            onChange: (faq, index) => setState(() {
                              faqTypeIndex = index;
                              faqType = faq;
                              listFAQ = ListFAQ.getListFAQ(faqType);
                            }),
                          ),
                          separatorBuilder: (context, index) => 12.widthSp,
                          itemCount: ListFAQ.map.length,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.sp,
                            vertical: 8.sp,
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
                            height: 24.sp,
                          ),
                          itemCount: listFAQ.length,
                        ),
                      ),
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
                      Text(
                        faq!.answer,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.medium,
                          color: context.textTheme.displayMedium!.color,
                        ),
                      ),
                      (context.viewPadding.bottom + 90.sp).height,
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

class FAQTypeChip extends StatelessWidget {
  const FAQTypeChip({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onChange,
  });

  final int index;
  final bool isSelected;
  final void Function(FAQType, int) onChange;

  @override
  Widget build(BuildContext context) {
    FAQType faq = ListFAQ.getFAQTypeFromIndex(index);
    return InkResponse(
      onTap: () => onChange(faq, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Styles.green : context.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10.sp),
          border: isSelected
              ? null
              : Border.all(
                  color: context.textTheme.headlineMedium!.color!,
                ),
        ),
        child: Text(
          faq.getTitle(context),
          style: Styles.poppins(
            fontSize: 14.sp,
            fontWeight: isSelected ? Styles.semiBold : Styles.regular,
            color: isSelected
                ? Colors.white
                : context.textTheme.displaySmall!.color,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
