import 'package:flutter/material.dart';

import '../enums.dart';

class NotifierPersonViewMode extends ValueNotifier<SearchViewPage> {
  SearchTab searchTab = SearchTab.products;

  NotifierPersonViewMode({
    SearchViewPage viewPage = SearchViewPage.normal,
    SearchTab searchTab = SearchTab.products,
  }) : super(viewPage);

  bool get isNotInPageNormal => value != SearchViewPage.normal;

  bool get isInPageNormal => value == SearchViewPage.normal;

  bool get isInLoadingPage => value == SearchViewPage.loading;

  bool get isInEmptyPage => value == SearchViewPage.empty;

  bool get isInPageSuggestions => value == SearchViewPage.suggestions;

  bool get isNotInPageSuggestions => value != SearchViewPage.suggestions;

  bool get isInPageResults => value == SearchViewPage.results;

  bool get isInTabProducts => searchTab == SearchTab.products;

  bool get isInTabCompanies => searchTab == SearchTab.companies;

  void reset() {
    value = SearchViewPage.normal;
    searchTab = SearchTab.products;
    notifyListeners();
  }

  void openPageSuggestions() {
    value = SearchViewPage.suggestions;
    notifyListeners();
  }

  void openPageLoading() {
    value = SearchViewPage.loading;
    notifyListeners();
  }

  void openPageResults() {
    value = SearchViewPage.results;
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
