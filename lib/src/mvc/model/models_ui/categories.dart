import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../tools.dart';
import '../enums.dart';

class Categories {
  static Map<Category, String> titles = {};
  static Map<Category, String> subtitles = {};
  static Map<Category, IconData> icons = {};

  static void init(BuildContext context) {
    titles.clear();
    titles = {
      Category.agriculture: AppLocalizations.of(context)!.agriculture,
      Category.livestock: AppLocalizations.of(context)!.livestock,
      Category.fishing: AppLocalizations.of(context)!.fishing,
      Category.phytosnitary: AppLocalizations.of(context)!.phytosnitary,
      Category.localFoodProducts:
          AppLocalizations.of(context)!.local_food_products,
      Category.rentalStorageFacilities:
          AppLocalizations.of(context)!.rental_storage_facilities,
    };
    subtitles.clear();
    subtitles = {
      Category.agriculture: AppLocalizations.of(context)!.agriculture_subtitle,
      Category.livestock: AppLocalizations.of(context)!.livestock_subtitle,
      Category.fishing: AppLocalizations.of(context)!.fishing_subtitle,
      Category.phytosnitary:
          AppLocalizations.of(context)!.phytosnitary_subtitle,
      Category.localFoodProducts:
          AppLocalizations.of(context)!.local_food_products_subtitle,
      Category.rentalStorageFacilities:
          AppLocalizations.of(context)!.rental_storage_facilities_subtitle,
    };
    icons.clear();
    icons = {
      Category.agriculture: AwesomeIcons.agriculture,
      Category.livestock: AwesomeIcons.livestock,
      Category.fishing: AwesomeIcons.fishing,
      Category.phytosnitary: AwesomeIcons.phytosnitary,
      Category.localFoodProducts: AwesomeIcons.food,
      Category.rentalStorageFacilities: AwesomeIcons.rental,
    };
  }
}
