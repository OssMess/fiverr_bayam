import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';

extension AccountPreferenceExtensions on AccountPreference {
  String translate(BuildContext context) {
    return {
      AccountPreference.paddyrice: AppLocalizations.of(context)!.paddyrice,
      AccountPreference.hulledrice: AppLocalizations.of(context)!.hulledrice,
      AccountPreference.freshcassava:
          AppLocalizations.of(context)!.freshcassava,
      AccountPreference.driedcassava:
          AppLocalizations.of(context)!.driedcassava,
      AccountPreference.sweetpotatoes:
          AppLocalizations.of(context)!.sweetpotatoes,
      AccountPreference.potatoes: AppLocalizations.of(context)!.potatoes,
      AccountPreference.bananas: AppLocalizations.of(context)!.bananas,
      AccountPreference.blantains: AppLocalizations.of(context)!.blantains,
    }[this]!;
  }

  String get getString => {
        AccountPreference.paddyrice: 'paddyrice',
        AccountPreference.hulledrice: 'hulledrice',
        AccountPreference.freshcassava: 'freshcassava',
        AccountPreference.driedcassava: 'driedcassava',
        AccountPreference.sweetpotatoes: 'sweetpotatoes',
        AccountPreference.potatoes: 'potatoes',
        AccountPreference.bananas: 'bananas',
        AccountPreference.blantains: 'blantains',
      }[this]!;
}
