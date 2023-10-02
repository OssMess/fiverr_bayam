import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension PlanTypeExtensions on PlanType {
  String translate(BuildContext context) => {
        PlanType.byCity: AppLocalizations.of(context)!.by_city,
        PlanType.byCountry: AppLocalizations.of(context)!.by_country,
      }[this]!;

  String get key => {
        PlanType.byCity: 'by_city',
        PlanType.byCountry: 'by_country',
      }[this]!;
}
