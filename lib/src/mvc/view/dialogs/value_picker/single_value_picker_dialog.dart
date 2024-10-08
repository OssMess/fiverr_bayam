import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../tools.dart';
import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/models_ui.dart';
import '../../dialogs.dart';
import '../../model_widgets.dart';

/// An `AdaptiveBottomSheet` to display options the user can pick one value from.
class SingleValuePickerDialog extends StatelessWidget {
  const SingleValuePickerDialog({
    super.key,
    required this.title,
    required this.values,
    required this.initialValue,
    this.hintText,
    this.searchable = false,
    this.searchStartsWith = false,
    required this.physics,
    required this.onPick,
    required this.mainAxisSize,
  }) : assert((!searchable && !searchStartsWith && hintText == null) ||
            searchable);

  /// Dialog title
  final String title;

  /// options
  final List<String> values;

  /// initial picked value
  final String? initialValue;

  /// Search text field hint
  final String? hintText;

  ///   - if `true`, search values and return those that start with the quesry test.
  ///   - if `false`, search values and return those that contain quesry test.
  final bool searchable;

  /// Used to configure how options are filtered during search for quick access:
  /// - if `true`: filter options that start with the search input text,
  /// - if `false`: filter options that contain the search input text,
  final bool searchStartsWith;

  /// scroll behavior
  final ScrollPhysics physics;

  /// on pick values, specifically a `String`
  final void Function(String) onPick;

  /// defines the size of the bottom sheet, MainAxisSize.max to take full screen,
  /// of MainAxisSize.min to take only part of the screen.
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    String pickedValue = initialValue ?? '';
    NotifierString searchNotifier = NotifierString.init('');
    return AdaptiveBottomSheet(
      mainAxisSize: mainAxisSize,
      continueButton: ModelTextButton(
        label: AppLocalizations.of(context)!.continu,
        fontColor: Styles.green,
        onPressed: () async {
          context.pop();
          if (pickedValue.isEmpty) {
            return;
          }
          if (pickedValue == AppLocalizations.of(context)!.all) {
            onPick('');
          } else {
            onPick(pickedValue);
          }
        },
      ),
      cancelButton: ModelTextButton(
        label: AppLocalizations.of(context)!.close,
        fontColor: Styles.red,
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
        if (searchable)
          CustomTextFormField(
            hintText: hintText,
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
            RegExp pattern =
                searchStartsWith ? RegExp(r'^' + search) : RegExp(r'' + search);
            Iterable<String> elements = values
                .where((element) => pattern.hasMatch(element.toLowerCase()));
            return StatefulBuilder(
              builder: (context, setState) {
                var container = Container(
                  foregroundDecoration: mainAxisSize == MainAxisSize.max
                      ? BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.scaffoldBackgroundColor,
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0),
                              context.scaffoldBackgroundColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0, 0.05, 0.95, 1],
                          ),
                        )
                      : null,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: physics,
                    padding: EdgeInsetsDirectional.fromSTEB(
                      10.w,
                      20.h,
                      0,
                      0,
                    ),
                    itemBuilder: (context, index) => CustomRadioButton<String>(
                      value: elements.elementAt(index),
                      groupValue: pickedValue,
                      label: elements.elementAt(index),
                      onChanged: (value) {
                        setState(() {
                          pickedValue = value!;
                        });
                      },
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox.shrink(),
                    itemCount: elements.length,
                  ),
                );
                if (mainAxisSize == MainAxisSize.max) {
                  return Expanded(
                    child: container,
                  );
                } else {
                  return container;
                }
              },
            );
          },
        ),
      ],
    );
  }
}
