import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
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
  Set<AccountPreference> pickedPreferences = {};
  Set<AccountPreference> filteredPreferences = {};
  Set<AccountPreference> allPreferences = {
    AccountPreference.paddyrice,
    AccountPreference.hulledrice,
    AccountPreference.freshcassava,
    AccountPreference.driedcassava,
    AccountPreference.sweetpotatoes,
    AccountPreference.potatoes,
    AccountPreference.bananas,
    AccountPreference.blantains,
  };

  @override
  void initState() {
    super.initState();
    filteredPreferences.addAll(allPreferences);
  }

  @override
  void dispose() {
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
              child: Column(
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
                        filteredPreferences.clear();
                        filteredPreferences.addAll(
                          allPreferences.where(
                            (element) => element
                                .translate(context)
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
                      itemBuilder: (context, index) => StatefulBuilder(
                        builder: (context, setState) {
                          AccountPreference preference =
                              filteredPreferences.elementAt(index);
                          return PreferenceCheckListTile(
                            checked: pickedPreferences.contains(preference),
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
                      itemCount: filteredPreferences.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    if (pickedPreferences.length < 3) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.select_at_least_nb_preferences,
      );
      return;
    }
    widget.userSession.preferences =
        pickedPreferences.map((e) => e.key).toList();
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
  final AccountPreference preference;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CustomCheckBox(
            value: checked,
            label: preference.translate(context),
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
