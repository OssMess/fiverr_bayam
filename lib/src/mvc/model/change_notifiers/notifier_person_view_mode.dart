import 'package:flutter/material.dart';

import '../enums.dart';

class NotifierPersonViewMode extends ValueNotifier<PersonViewPage> {
  SearchTab searchTab = SearchTab.products;

  NotifierPersonViewMode({
    PersonViewPage viewPage = PersonViewPage.normal,
    SearchTab searchTab = SearchTab.products,
  }) : super(viewPage);

  bool get isNotInPageNormal => value != PersonViewPage.normal;

  bool get isInPageNormal => value == PersonViewPage.normal;

  bool get isInPageSuggestions => value == PersonViewPage.suggestions;

  bool get isNotInPageSuggestions => value != PersonViewPage.suggestions;

  bool get isInPageResults => value == PersonViewPage.results;

  bool get isInTabProducts => searchTab == SearchTab.products;

  bool get isInTabCompanies => searchTab == SearchTab.companies;

  void reset() {
    value = PersonViewPage.normal;
    searchTab = SearchTab.products;
    notifyListeners();
  }

  void openPageSuggestions() {
    value = PersonViewPage.suggestions;
    notifyListeners();
  }

  void openPageResults() {
    value = PersonViewPage.results;
    notifyListeners();
  }

  void openTabProducts() {
    searchTab = SearchTab.products;
    notifyListeners();
  }

  void openTabCompanies() {
    searchTab = SearchTab.companies;
    notifyListeners();
  }
}
