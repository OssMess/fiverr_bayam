import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';

class PickCategorySub extends StatefulWidget {
  const PickCategorySub({
    super.key,
    required this.userSession,
    required this.initialCategorySub,
    required this.onPick,
  });

  final UserSession userSession;
  final CategorySub? initialCategorySub;
  final void Function(CategorySub) onPick;

  @override
  State<PickCategorySub> createState() => _PickCategorySubState();
}

class _PickCategorySubState extends State<PickCategorySub> {
  CategorySub? pickedCategorySub;

  Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    widget.userSession.listCategoriesSub!.initData(callGet: true);
    pickedCategorySub = widget.initialCategorySub;
    super.initState();
  }

  @override
  void dispose() {
    widget.userSession.listCategories?.onResetSearch();
    widget.userSession.listCategoriesSub?.onResetSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.continu,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: ChangeNotifierProvider.value(
                value: widget.userSession.listCategoriesSub!,
                child: Consumer<ListCategoriesSub>(
                  builder: (context, list, _) {
                    if (list.isNull) {
                      return const Align(
                        alignment: Alignment.topCenter,
                        child: CustomLoadingIndicator(
                          isSliver: false,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .select_at_least_nb_preferences,
                          style: Styles.poppins(
                            fontSize: 18.sp,
                            fontWeight: Styles.semiBold,
                            color: context.textTheme.displayLarge!.color,
                          ),
                        ),
                        16.heightSp,
                        CustomTextFormField(
                          prefixIcon: AwesomeIcons.magnifying_glass,
                          suffixIcon: AwesomeIcons.sliders_outlined,
                          onChanged: (value) {
                            debouncer.run(
                              () {
                                widget.userSession.listCategoriesSub
                                    ?.onUpdateSearch(value);
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                              top: 32.sp,
                              bottom: context.viewPadding.bottom + 90.sp,
                            ),
                            itemBuilder: (context, index) => StatefulBuilder(
                              builder: (context, setState) {
                                CategorySub preference =
                                    list.list.elementAt(index);
                                return PreferenceCheckListTile(
                                  checked: pickedCategorySub == preference,
                                  preference: preference,
                                  onChange: (added) {
                                    if (added) {
                                      pickedCategorySub = preference;
                                    } else {
                                      pickedCategorySub = null;
                                    }
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            separatorBuilder: (_, __) => 24.heightSp,
                            itemCount: list.list.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    if (pickedCategorySub == null) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.select_ad_category,
      );
      return;
    }
    widget.onPick(pickedCategorySub!);
    context.pop();
  }
}
