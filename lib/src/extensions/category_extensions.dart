import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mvc/model/enums.dart';
import '../tools.dart';

extension CategoryExtensions on Category {
  String translateTitle(BuildContext context) => {
        Category.agriculture: AppLocalizations.of(context)!.agriculture,
        Category.livestock: AppLocalizations.of(context)!.livestock,
        Category.fishing: AppLocalizations.of(context)!.fishing,
        Category.phytosnitary: AppLocalizations.of(context)!.phytosnitary,
        Category.localFoodProducts:
            AppLocalizations.of(context)!.local_food_products,
        Category.rentalStorageFacilities:
            AppLocalizations.of(context)!.rental_storage_facilities,
      }[this]!;

  String translateSubtitle(BuildContext context) => {
        Category.agriculture:
            AppLocalizations.of(context)!.agriculture_subtitle,
        Category.livestock: AppLocalizations.of(context)!.livestock_subtitle,
        Category.fishing: AppLocalizations.of(context)!.fishing_subtitle,
        Category.phytosnitary:
            AppLocalizations.of(context)!.phytosnitary_subtitle,
        Category.localFoodProducts:
            AppLocalizations.of(context)!.local_food_products_subtitle,
        Category.rentalStorageFacilities:
            AppLocalizations.of(context)!.rental_storage_facilities_subtitle,
      }[this]!;

  String get key => {
        Category.agriculture: 'agriculture',
        Category.livestock: 'livestock',
        Category.fishing: 'fishing',
        Category.phytosnitary: 'phytosnitary',
        Category.localFoodProducts: 'localFoodProducts',
        Category.rentalStorageFacilities: 'rentalStorageFacilities',
      }[this]!;

  IconData get icon => {
        Category.agriculture: AwesomeIcons.agriculture,
        Category.livestock: AwesomeIcons.livestock,
        Category.fishing: AwesomeIcons.fishing,
        Category.phytosnitary: AwesomeIcons.phytosnitary,
        Category.localFoodProducts: AwesomeIcons.food,
        Category.rentalStorageFacilities: AwesomeIcons.rental,
      }[this]!;
}
