import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension PlanDurationExtensions on PlanDuration {
  String translate(BuildContext context) => {
        PlanDuration.monthly: AppLocalizations.of(context)!.monthly,
        PlanDuration.biannual: AppLocalizations.of(context)!.biannual,
        PlanDuration.annual: AppLocalizations.of(context)!.annual,
      }[this]!;

  String translatePlan(BuildContext context) => {
        PlanDuration.monthly: AppLocalizations.of(context)!.monthly_plan,
        PlanDuration.biannual: AppLocalizations.of(context)!.biannual_plan,
        PlanDuration.annual: AppLocalizations.of(context)!.annual_plan,
      }[this]!;

  String get key => {
        PlanDuration.monthly: 'monthly',
        PlanDuration.biannual: 'biannual',
        PlanDuration.annual: 'annual',
      }[this]!;

  int get months => {
        PlanDuration.monthly: 1,
        PlanDuration.biannual: 6,
        PlanDuration.annual: 12,
      }[this]!;
}
