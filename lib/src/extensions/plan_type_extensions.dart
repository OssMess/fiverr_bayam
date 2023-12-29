import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension PlanTypeExtensions on PlanType {
  String translate(BuildContext context) => {
        PlanType.basic: AppLocalizations.of(context)!.basic,
        PlanType.advanced: AppLocalizations.of(context)!.advanced,
        PlanType.illimited: AppLocalizations.of(context)!.unlimited,
      }[this]!;

  String translateSubtitle(BuildContext context) => {
        PlanType.basic: AppLocalizations.of(context)!.basic_subtitle,
        PlanType.advanced: AppLocalizations.of(context)!.advanced_subtitle,
        PlanType.illimited: AppLocalizations.of(context)!.unlimited_subtitle,
      }[this]!;

  String get key => {
        PlanType.basic: 'BASE',
        PlanType.advanced: 'ADVANCED',
        PlanType.illimited: 'ILLIMITED',
      }[this]!;
}
