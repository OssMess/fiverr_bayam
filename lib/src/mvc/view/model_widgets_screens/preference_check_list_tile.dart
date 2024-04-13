import 'package:flutter/material.dart';

import '../../model/models.dart';
import '../model_widgets.dart';

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
