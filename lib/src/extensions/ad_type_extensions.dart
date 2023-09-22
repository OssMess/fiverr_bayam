import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

Map<AdType, Color> backgroundColors = {
  AdType.forRent: Styles.orange,
  AdType.forSell: Styles.green,
  AdType.wantToBuy: Styles.red,
};

extension AdTypeExtensions on AdType {
  Color get toBackgroundColor => backgroundColors[this]!;

  String toTitle(BuildContext context) {
    return {
      AdType.forRent: AppLocalizations.of(context)!.for_rent,
      AdType.forSell: AppLocalizations.of(context)!.for_sale,
      AdType.wantToBuy: AppLocalizations.of(context)!.want_to_buy,
    }[this]!;
  }
}
