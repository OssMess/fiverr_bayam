import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompletePreferences extends StatefulWidget {
  const CompletePreferences({
    super.key,
    required this.userSession,
    required this.accountType,
  });

  final UserSession userSession;
  final AccountType accountType;

  @override
  State<CompletePreferences> createState() => _CompletePreferencesState();
}

class _CompletePreferencesState extends State<CompletePreferences> {
  Set<CategorySub> pickedPreferences = {};
  Set<CategorySub>? filteredPreferences;
  Set<CategorySub>? allPreferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategorySub>>(
      future: allPreferences == null
          ? CategoriesSubServices.of(widget.userSession).get()
          : null,
      builder: (context, snapshot) {
        if (snapshot.hasData && allPreferences == null) {
          allPreferences = snapshot.data!.toSet();
          filteredPreferences = {};
          filteredPreferences!.addAll(allPreferences!);
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          floatingActionButton: CustomElevatedButton(
            onPressed: next,
            label: AppLocalizations.of(context)!.continu,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
                  child: allPreferences != null
                      ? Column(
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
                                setState(() {
                                  filteredPreferences!.clear();
                                  filteredPreferences!.addAll(
                                    allPreferences!.where(
                                      (element) => element.name
                                          .toLowerCase()
                                          .contains(value),
                                    ),
                                  );
                                });
                              },
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.only(
                                  top: 32.sp,
                                  bottom: context.viewPadding.bottom + 90.sp,
                                ),
                                itemBuilder: (context, index) =>
                                    StatefulBuilder(
                                  builder: (context, setState) {
                                    CategorySub preference =
                                        filteredPreferences!.elementAt(index);
                                    return PreferenceCheckListTile(
                                      checked: pickedPreferences
                                          .contains(preference),
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
                                itemCount: filteredPreferences!.length,
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: CustomLoadingIndicator(
                            isSliver: false,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> next() async {
    // CategoriesSubServices.of(widget.userSession).post(
    //   name: 'sub-category 4',
    //   description: '',
    //   category: '68672060-6fa5-4e5b-8852-7fe8a1d735c2',
    // );
    // return;
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
