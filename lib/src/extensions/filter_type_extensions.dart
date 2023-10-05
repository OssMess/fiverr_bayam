import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension FilterTypeExtensions on FilterType {
  String translate(BuildContext context) => {
        FilterType.country: AppLocalizations.of(context)!.country,
        FilterType.region: AppLocalizations.of(context)!.region,
        FilterType.adtype: AppLocalizations.of(context)!.type_of_ads,
      }[this]!;
}
