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
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../screens.dart';

class CompletePreferences extends StatefulWidget {
  const CompletePreferences({
    super.key,
    required this.userSession,
    this.imageProfile,
    this.imageCompany,
    this.accountType,
    this.onPick,
  }) : assert((accountType == null && onPick != null) ||
            (accountType != null && onPick == null));

  final UserSession userSession;
  final XFile? imageProfile;
  final Set<XFile>? imageCompany;
  final AccountType? accountType;
  final void Function(Set<CategorySub>)? onPick;

  @override
  State<CompletePreferences> createState() => _CompletePreferencesState();
}

class _CompletePreferencesState extends State<CompletePreferences> {
  Set<CategorySub> pickedPreferences = {};

  Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    widget.userSession.listCategoriesSub!.initData(callGet: true);
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
                                  checked: pickedPreferences
                                      .map((element) => element.uuid)
                                      .contains(preference.uuid),
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
    /// Code to manually create a category with several sub categories
    // CategoriesServices.of(widget.userSession)
    //     .post(
    //   name: 'Agriculture commerciale',
    //   description: '',
    // )
    //     .then(
    //   (category) async {
    //     log('Category created : uuid = ${category.uuid}');
    //     List<String> subCategories = [
    //       'Grandes cultures',
    //       'Cultures maraîchères',
    //     ];
    //     List<String> subCategoriesUID = [];
    //     for (var subcategory in subCategories) {
    //       CategorySub subCategory =
    //           await CategoriesSubServices.of(widget.userSession).post(
    //         name: subcategory,
    //         description: '',
    //         categoryId: category.uuid,
    //       );
    //       log('Subcategory created : uuid = ${subCategory.uuid}');
    //       subCategoriesUID.add(subCategory.uuid);
    //     }
    //     log('created ${subCategoriesUID.length}/${subCategories.length} categories');
    //   },
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
              imageProfile: widget.imageProfile,
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
