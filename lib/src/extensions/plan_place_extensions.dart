import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension PlanPlaceExtensions on PlanPlace {
  String translate(BuildContext context) => {
        PlanPlace.byCity: AppLocalizations.of(context)!.by_city,
        PlanPlace.byCountry: AppLocalizations.of(context)!.by_country,
      }[this]!;

  String get key => {
        PlanPlace.byCity: 'VILLE',
        PlanPlace.byCountry: 'COUNTRY',
      }[this]!;
}
