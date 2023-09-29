import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompleteRegistrationFormP2 extends StatefulWidget {
  const CompleteRegistrationFormP2({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationFormP2> createState() =>
      _CompleteRegistrationFormP2State();
}

class _CompleteRegistrationFormP2State
    extends State<CompleteRegistrationFormP2> {
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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const CustomAppBarLogo(),
        leading: AppBarActionButton(
          icon: context.backButtonIcon,
          onTap: () => context.pop(),
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.continu,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select at least 3 preferences',
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
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        if (widget.userSession.isPerson) {
          context.push(
            widget: CompleteRegistrationFormP3(
              userSession: widget.userSession,
            ),
          );
        } else {
          context.popUntilFirst();
          widget.userSession.onRegisterCompleted(
            uid: 0,
            accountType: AccountType.company,
            firstName: 's',
            lastName: 's',
          );
        }
      },
      onError: (_) {},
    );
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
