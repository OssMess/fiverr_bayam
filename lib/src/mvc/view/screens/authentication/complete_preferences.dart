import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompletePreferences extends StatefulWidget {
  const CompletePreferences({
    super.key,
    required this.userSession,
    this.imageCompany,
    this.accountType,
    this.onPick,
  }) : assert((accountType == null && onPick != null) ||
            (accountType != null && onPick == null));

  final UserSession userSession;
  final XFile? imageCompany;
  final AccountType? accountType;
  final void Function(Set<CategorySub>)? onPick;

  @override
  State<CompletePreferences> createState() => _CompletePreferencesState();
}

class _CompletePreferencesState extends State<CompletePreferences> {
  Set<CategorySub> pickedPreferences = {};

  @override
  void initState() {
    widget.userSession.listCategoriesSub!.initData(callGet: true);
    super.initState();
  }

  @override
  void dispose() {
    widget.userSession.listCategories?.onChangeFilter('');
    widget.userSession.listCategoriesSub?.onChangeFilter('');
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
              onTap: () => context.pop(),
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
                          onChanged: list.onChangeFilter,
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
                                    list.filterSet.elementAt(index);
                                return PreferenceCheckListTile(
                                  checked:
                                      pickedPreferences.contains(preference),
                                  preference: preference,
                                  onChange: (added) {
                                    if (added) {
                                      pickedPreferences.add(preference);
                                    } else {
                                      pickedPreferences.remove(preference);
                                    }
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            separatorBuilder: (_, __) => 24.heightSp,
                            itemCount: list.filterSet.length,
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
    // CategoriesSubServices.of(widget.userSession).post(
    //   name: 'sub-category 4',
    //   description: '',
    //   category: '68672060-6fa5-4e5b-8852-7fe8a1d735c2',
    // );
    // return;
    if (widget.accountType != null) {
      if (pickedPreferences.length < 3) {
        Dialogs.of(context).showSnackBar(
          message: AppLocalizations.of(context)!.select_at_least_nb_preferences,
        );
        return;
      }
      widget.userSession.preferences =
          pickedPreferences.map((e) => e.uuid).toList();
      switch (widget.accountType) {
        case AccountType.company:
          context.push(
            widget: CompleteRegistrationC2(
              userSession: widget.userSession,
              imageCompany: widget.imageCompany,
            ),
          );
          break;
        case AccountType.person:
          context.push(
            widget: CompleteRegistrationP1(
              userSession: widget.userSession,
            ),
          );
          break;
        default:
      }
    } else {
      if (pickedPreferences.length < 3) {
        Dialogs.of(context).showSnackBar(
          message: AppLocalizations.of(context)!.select_at_least_nb_preferences,
        );
        return;
      }
      widget.onPick!(pickedPreferences);
    }
  }
}

class PreferenceCheckListTile extends StatelessWidget {
  const PreferenceCheckListTile({
    super.key,
    required this.checked,
    required this.preference,
    required this.onChange,
  });

  final bool checked;
  final CategorySub preference;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CustomCheckBox(
            value: checked,
            label: preference.name,
            onChanged: (value) {
              if (value == null) return;
              onChange(value);
            },
          ),
        ),
      ],
    );
  }
}
