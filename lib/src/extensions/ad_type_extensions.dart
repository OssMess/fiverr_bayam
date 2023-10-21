import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

Map<AdType, Color> backgroundColors = {
  AdType.rent: Styles.orange,
  AdType.sell: Styles.green,
  AdType.want: const Color(0xFFD80027),
};

extension AdTypeExtensions on AdType {
  Color get toBackgroundColor => backgroundColors[this]!;

  String translate(BuildContext context) {
    return {
      AdType.rent: AppLocalizations.of(context)!.for_rent,
      AdType.sell: AppLocalizations.of(context)!.for_sale,
      AdType.want: AppLocalizations.of(context)!.want_to_buy,
    }[this]!;
  }

  int get index => {
        AdType.rent: 0,
        AdType.sell: 1,
        AdType.want: 3,
      }[this]!;

  String get key => {
        AdType.rent: 'rent',
        AdType.sell: 'sell',
        AdType.want: 'want',
      }[this]!;
}
