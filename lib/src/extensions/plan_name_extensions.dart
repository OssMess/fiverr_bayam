import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension PlanNameExtensions on PlanName {
  String translate(BuildContext context) => {
        PlanName.basic: AppLocalizations.of(context)!.basic,
        PlanName.advanced: AppLocalizations.of(context)!.advanced,
        PlanName.unlimited: AppLocalizations.of(context)!.unlimited,
      }[this]!;

  String translateSubtitle(BuildContext context) => {
        PlanName.basic: AppLocalizations.of(context)!.basic_subtitle,
        PlanName.advanced: AppLocalizations.of(context)!.advanced_subtitle,
        PlanName.unlimited: AppLocalizations.of(context)!.unlimited_subtitle,
      }[this]!;

  String get key => {
        PlanName.basic: 'basic',
        PlanName.advanced: 'advanced',
        PlanName.unlimited: 'unlimited',
      }[this]!;
}
