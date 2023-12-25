import 'package:flutter/material.dart';

import '../models.dart';

/// List user upcoming appointments (Set<`Appointment`>):
abstract class SetClasses<T> with ChangeNotifier {
  /// User session.
  final UserSession userSession;

  /// Set of unique `T`.
  Set<T> list = {};

  /// is in init state and requires initialization.
  bool isNull = true;

  /// is awaiting for response from get HTTP request, used to avoid duplicated requests.
  bool isLoading = false;

  /// has error after the last HTTP request
  bool hasError = false;

  SetClasses({required this.userSession});

  /// The number of nearby salons in list.
  int get length => list.length;

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
      refresh: false,
      onComplete: onComplete,
    );
  }

  /// call get to retrieve data from backend.
  Future<void> get({
    required bool refresh,
    void Function()? onComplete,
  });

  /// Refresh data.
  Future<void> refresh([
    void Function()? onComplete,
  ]) async {
    if (isLoading) return;
    hasError = false;
    isLoading = true;
    await get(
      refresh: true,
      onComplete: onComplete,
    );
  }

  /// Update list with query result, and notify listeners
  void update(
    Set<T> result,
    bool error,
    bool refresh,
  ) {
    if (error || refresh) {
      list.clear();
    }
    list.addAll(result);
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
  }

  /// Clone the values of all attributs of [update] to `this` and refresh the UI.
  /// The aim here is to update to `this` and keep all widgets attached to `this` notifiable.
  void updateFrom(SetClasses<T> update) {
    list = update.list;
    isNull = update.isNull;
    isLoading = update.isLoading;
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
}
