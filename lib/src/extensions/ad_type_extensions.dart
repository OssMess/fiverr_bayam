import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

Map<AdType, Color> backgroundColors = {
  AdType.forRent: Styles.orange,
  AdType.forSell: Styles.green,
  AdType.wantToBuy: const Color(0xFFD80027),
};

extension AdTypeExtensions on AdType {
  Color get toBackgroundColor => backgroundColors[this]!;

  String translate(BuildContext context) {
    return {
      AdType.forRent: AppLocalizations.of(context)!.for_rent,
      AdType.forSell: AppLocalizations.of(context)!.for_sale,
      AdType.wantToBuy: AppLocalizations.of(context)!.want_to_buy,
    }[this]!;
  }

  int get index => {
        AdType.forRent: 0,
        AdType.forSell: 1,
        AdType.wantToBuy: 3,
      }[this]!;

  String get key => {
        AdType.forRent: 'for_rent',
        AdType.forSell: 'for_sell',
        AdType.wantToBuy: 'want_buy',
      }[this]!;
}
