import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension CategoryExtensions on AdCategory {
  String translateTitle(BuildContext context) => {
        AdCategory.agriculture: AppLocalizations.of(context)!.agriculture,
        AdCategory.livestock: AppLocalizations.of(context)!.livestock,
        AdCategory.fishing: AppLocalizations.of(context)!.fishing,
        AdCategory.phytosnitary: AppLocalizations.of(context)!.phytosnitary,
        AdCategory.localFoodProducts:
            AppLocalizations.of(context)!.local_food_products,
        AdCategory.rentalStorageFacilities:
            AppLocalizations.of(context)!.rental_storage_facilities,
      }[this]!;

  String translateSubtitle(BuildContext context) => {
        AdCategory.agriculture:
            AppLocalizations.of(context)!.agriculture_subtitle,
        AdCategory.livestock: AppLocalizations.of(context)!.livestock_subtitle,
        AdCategory.fishing: AppLocalizations.of(context)!.fishing_subtitle,
        AdCategory.phytosnitary:
            AppLocalizations.of(context)!.phytosnitary_subtitle,
        AdCategory.localFoodProducts:
            AppLocalizations.of(context)!.local_food_products_subtitle,
        AdCategory.rentalStorageFacilities:
            AppLocalizations.of(context)!.rental_storage_facilities_subtitle,
      }[this]!;

  String get key => {
        AdCategory.agriculture: 'agriculture',
        AdCategory.livestock: 'livestock',
        AdCategory.fishing: 'fishing',
        AdCategory.phytosnitary: 'phytosnitary',
        AdCategory.localFoodProducts: 'localFoodProducts',
        AdCategory.rentalStorageFacilities: 'rentalStorageFacilities',
      }[this]!;

  IconData get icon => {
        AdCategory.agriculture: AwesomeIcons.agriculture,
        AdCategory.livestock: AwesomeIcons.livestock,
        AdCategory.fishing: AwesomeIcons.fishing,
        AdCategory.phytosnitary: AwesomeIcons.phytosnitary,
        AdCategory.localFoodProducts: AwesomeIcons.food,
        AdCategory.rentalStorageFacilities: AwesomeIcons.rental,
      }[this]!;
}
