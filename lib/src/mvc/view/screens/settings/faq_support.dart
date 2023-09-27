import 'package:bayam/src/mvc/view/screens/settings/faq_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class FAQSupport extends StatefulWidget {
  const FAQSupport({super.key});

  @override
  State<FAQSupport> createState() => _FAQSupportState();
}

class _FAQSupportState extends State<FAQSupport> {
  int faqIndex = 0;
  FAQType faqType = FAQType.payment;
  late List<FAQ> listFAQ;

  @override
  void initState() {
    listFAQ = ListFAQ.getListFAQ(faqType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomElevatedButton(
        label: AppLocalizations.of(context)!.contact_support,
        onPressed: () {
          //TODO contact support
        },
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
              onTap: context.pop,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Text(
                    AppLocalizations.of(context)!.edit_profile,
                    style: Styles.poppins(
                      fontSize: 16.sp,
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
                      isSelected: index == faqIndex,
                      onChange: (faq, index) => setState(() {
                        faqIndex = index;
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
                      faq: ListFAQ.map[faqIndex][index],
                    ),
                    separatorBuilder: (context, index) => CustomDivider(
                      height: 24.sp,
                    ),
                    itemCount: listFAQ.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FAQListTile extends StatelessWidget {
  const FAQListTile({
    super.key,
    required this.faq,
  });

  final FAQ faq;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => context.push(widget: FAQAnswer(faq: faq)),
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
