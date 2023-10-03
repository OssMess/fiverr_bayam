import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/models_ui.dart';
import '../../dialogs.dart';
import '../../model_widgets.dart';

/// An `AdaptiveBottomSheet` to display options the user can pick multiple values from.
class MultiValuePickerDialog extends StatelessWidget {
  const MultiValuePickerDialog({
    super.key,
    required this.title,
    required this.hint,
    required this.values,
    required this.initialValues,
    required this.searchStartsWith,
    required this.physics,
    required this.onPick,
  });

  /// Dialog title
  final String title;

  /// Search text field hint
  final String hint;

  /// options
  final List<String> values;

  /// initial picked values
  final List<String> initialValues;

  /// Used to configure how options are filtered during search for quick access:
  /// - if `true`: filter options that start with the search input text,
  /// - if `false`: filter options that contain the search input text,
  final bool searchStartsWith;

  /// scroll behavior
  final ScrollPhysics physics;

  /// on pick values, specifically a list of `String`
  final void Function(List<String>) onPick;

  @override
  Widget build(BuildContext context) {
    List<String> pickedValues = [...initialValues];
    NotifierString searchNotifier = NotifierString.init('');
    return AdaptiveBottomSheet(
      mainAxisSize: MainAxisSize.min,
      continueAct: ModelTextButton(
        label: AppLocalizations.of(context)!.continu,
        onPressed: () async {
          context.pop();
          onPick(pickedValues);
        },
      ),
      cancelAct: ModelTextButton(
        label: AppLocalizations.of(context)!.close,
        onPressed: () => context.pop(),
      ),
      children: [
        Text(
          title,
          style: Styles.poppins(
            fontSize: 20.sp,
            fontWeight: Styles.bold,
            color: context.textTheme.displayLarge!.color,
          ),
        ),
        SizedBox(height: 20.sp),
        CustomTextFormField(
          hintText: hint,
          prefixIcon: AwesomeIcons.magnifying_glass,
          fillColor: Styles.green.shade50,
          prefixColor: Styles.green,
          onChanged: (value) {
            searchNotifier.setValue(value.toLowerCase());
          },
        ),
        ValueListenableBuilder(
            valueListenable: searchNotifier.notifier,
            builder: (context, search, _) {
              RegExp pattern = searchStartsWith
                  ? RegExp(r'^' + search)
                  : RegExp(r'' + search);
              Iterable<String> elements = values
                  .where((element) => pattern.hasMatch(element.toLowerCase()));
              return StatefulBuilder(builder: (context, setState) {
                return Expanded(
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.scaffoldBackgroundColor,
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0),
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0),
                          context.scaffoldBackgroundColor
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.1, 0.85, 1],
                      ),
                    ),
                    child: ListView.separated(
                      physics: physics,
                      padding: EdgeInsetsDirectional.fromSTEB(
                        10.w,
                        20.h,
                        0,
                        25.h,
                      ),
                      itemBuilder: (context, index) => CustomCheckBox(
                        value: pickedValues.contains(elements.elementAt(index)),
                        label: elements.elementAt(index),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            if (index == 0 && elements.elementAt(0) == 'All') {
                              if (value) {
                                pickedValues.addAll(values);
                              } else {
                                pickedValues.clear();
                              }
                            } else {
                              if (value) {
                                pickedValues.add(values.elementAt(index));
                                if (pickedValues.length == values.length - 1 &&
                                    values.contains(
                                        AppLocalizations.of(context)!.all)) {
                                  pickedValues
                                      .add(AppLocalizations.of(context)!.all);
                                }
                              } else {
                                pickedValues.remove(values.elementAt(index));
                                pickedValues
                                    .remove(AppLocalizations.of(context)!.all);
                              }
                            }
                          });
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox.shrink(),
                      itemCount: elements.length,
                    ),
                  ),
                );
              });
            }),
        SizedBox(height: 20.sp),
      ],
    );
  }
}
