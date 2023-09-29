import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension FAQTypeExtensions on FAQType {
  int get index => {
        FAQType.payment: 0,
        FAQType.cancellations: 1,
        FAQType.account: 2,
        FAQType.insurance: 3,
      }[this]!;

  String translate(BuildContext context) => {
        FAQType.payment: AppLocalizations.of(context)!.payment,
        FAQType.cancellations: AppLocalizations.of(context)!.cancellations,
        FAQType.account: AppLocalizations.of(context)!.account,
        FAQType.insurance: AppLocalizations.of(context)!.insurance,
      }[this]!;
}
