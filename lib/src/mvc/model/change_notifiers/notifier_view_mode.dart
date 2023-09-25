import 'package:flutter/material.dart';

import '../enums.dart';

class NotifierViewMode extends ValueNotifier<ViewPage> {
  SearchTab searchTab = SearchTab.products;

  NotifierViewMode({
    ViewPage viewPage = ViewPage.normal,
    SearchTab searchTab = SearchTab.products,
  }) : super(viewPage);

  bool get isNotInPageNormal => value != ViewPage.normal;

  bool get isInPageNormal => value == ViewPage.normal;

  bool get isInPageSuggestions => value == ViewPage.suggestions;

  bool get isNotInPageSuggestions => value != ViewPage.suggestions;

  bool get isInPageResults => value == ViewPage.results;

  bool get isInPageSearch => value == ViewPage.search;

  bool get isInTabProducts => searchTab == SearchTab.products;

  bool get isInTabCompanies => searchTab == SearchTab.companies;

  void reset() {
    value = ViewPage.normal;
    searchTab = SearchTab.products;
    notifyListeners();
  }

  void openPageSearch() {
    value = ViewPage.search;
    notifyListeners();
  }

  void openPageSuggestions() {
    value = ViewPage.suggestions;
    notifyListeners();
  }

  void openPageResults() {
    value = ViewPage.results;
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
