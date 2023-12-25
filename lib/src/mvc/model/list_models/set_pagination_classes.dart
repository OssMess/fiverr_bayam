import 'package:flutter/material.dart';

import '../models.dart';

/// List user upcoming appointments (Set<`Appointment`>):
abstract class SetPaginationClasses<T> with ChangeNotifier {
  /// User session
  final UserSession userSession;

  /// Set of unique `T`.
  Set<T> list = {};

  /// is in init state and requires initialization.
  bool isNull = true;

  /// is awaiting for response from get HTTP request, used to avoid duplicated requests.
  bool isLoading = false;

  /// has error after the last HTTP request
  bool hasError = false;

  /// total number of pages for appointments list.
  int totalElements = -1;

  /// current page.
  int currentPage = 0;

  SetPaginationClasses({required this.userSession});

  /// `true` if there are still more pages (pagination).
  bool get hasMore => length < totalElements;

  bool get canGetMore => (isNotNull && hasMore && !isLoading);

  /// The number of elements in list.
  int get length => list.length;

  /// The number of elements in the list, +1 if the list has more elements.
  int get childCount => list.length + (hasMore ? 1 : 1);

  bool get isNotNull => !isNull;

  /// `this.list` is empty.
  bool get isEmpty => list.isEmpty;

  /// `this.list` is not empty.
  bool get isNotEmpty => list.isNotEmpty;

  T elementAt(int index) => list.elementAt(index);

  /// Init data.
  /// if [callGet] is `true` proceed with query, else break.
  Future<void> initData({
    required bool callGet,
    void Function()? onComplete,
  }) async {
    if (!callGet) return;
    if (!isNull) return;
    if (isLoading) return;
    isLoading = true;
    await get(
      page: currentPage,
      refresh: false,
      onComplete: onComplete,
    );
  }

  /// call get to retrieve data from backend.
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  });

  /// Get more data, uses pagination.
  Future<void> getMore() async {
    if (isNull) return;
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    await get(
      page: currentPage,
      refresh: false,
    );
  }

  /// Refresh data.
  Future<void> refresh([void Function()? onComplete]) async {
    if (isLoading) return;
    totalElements = -1;
    currentPage = 0;
    hasError = false;
    isLoading = true;
    await get(
      page: currentPage,
      refresh: true,
      onComplete: onComplete,
    );
  }

  /// Update list with query result, and notify listeners
  void update(
    Set<T> result,
    int totalPages,
    int currentPage,
    bool error,
    bool refresh,
  ) {
    if (error || refresh) {
      list.clear();
    }
    list.addAll(result);
    this.totalElements = totalPages;
    this.currentPage = currentPage;
    isLoading = false;
    isNull = false;
    hasError = error;
    notifyListeners();
  }

  /// Reset list to its initial state.
  void reset() {
    isNull = true;
    isLoading = false;
    hasError = false;
    list.clear();
    totalElements = -1;
    currentPage = 0;
  }

  /// Clone the values of all attributs of [update] to `this` and refresh the UI.
  /// The aim here is to update to `this` and keep all widgets attached to `this` notifiable.
  void updateFrom(SetPaginationClasses<T> update) {
    list = update.list;
    isNull = update.isNull;
    isLoading = update.isLoading;
    totalElements = update.totalElements;
    currentPage = update.currentPage;
    hasError = update.hasError;
    notifyListeners();
  }

  void insert(T element) {
    if (isNull) return;
    Set<T> newList = {element, ...list};
    list.clear();
    list = newList;
    notifyListeners();
  }

  ///For lazzy loading, Use [scrollNotification] to detect if the scroll has
  ///reached the end of the page, and if the list has more data, call `getMore`.
  ///if [muteScrollNotification] is set to true, mute scroll notification in the
  ///widget tree, else notify top-level widgets.
  bool onMaxScrollExtent(
    ScrollNotification scrollNotification, [
    bool muteScrollNotification = false,
  ]) {
    if (isNull) return !muteScrollNotification;
    if (isLoading) return !muteScrollNotification;
    if (!canGetMore) return !muteScrollNotification;
    if (scrollNotification.metrics.pixels !=
        scrollNotification.metrics.maxScrollExtent) {
      return !muteScrollNotification;
    }
    getMore();
    return !muteScrollNotification;
  }

  ///For lazzy loading, Use [scrollNotification] to detect if the scroll is
  ///[extentAfter] away from the end of the page, and if the list has more data,
  /// call `getMore`. if [muteScrollNotification] is set to true, mute scroll
  /// notification in the widget tree, else notify top-level widgets.
  bool onExtentAfter(
    ScrollNotification scrollNotification,
    double extentAfter, [
    bool muteScrollNotification = false,
  ]) {
    if (isNull) return !muteScrollNotification;
    if (isLoading) return !muteScrollNotification;
    if (!canGetMore) return !muteScrollNotification;
    if (scrollNotification.metrics.extentAfter < extentAfter) {
      return !muteScrollNotification;
    }
    getMore();
    return !muteScrollNotification;
  }

  /// Add listener to [controller] to listen for pagination and load more results
  /// if there are any.
  void addControllerListener(ScrollController controller) {
    controller.addListener(() {
      if (isNull) return;
      if (isLoading) return;
      if (!canGetMore) return;
      if (controller.position.maxScrollExtent != controller.offset) return;
      getMore();
    });
  }
}
