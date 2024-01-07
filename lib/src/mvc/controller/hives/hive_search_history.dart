import 'dart:convert';
import 'package:hive/hive.dart';

import '../../model/models.dart';

class HiveSearchHistory {
  static late Box _box;

  static List<SearchHistory> list = [];

  static const String _boxName = 'search history';

  static Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    if (_box.isNotEmpty) {
      list = List.from(_box.values)
          .map(
            (e) => SearchHistory.fromMap(
              e,
            ),
          )
          .toList();
    }
  }

  /// Save [json] to `_box`.
  static Future<void> save(SearchHistory searchHistory) async {
    list.add(searchHistory);
    await _box.delete(searchHistory.categorySub.uuid);
    await _box.put(
      searchHistory.categorySub.uuid,
      searchHistory.toMapInit,
    );
  }

  static Future<void> delete(SearchHistory searchHistory) async {
    list.remove(searchHistory);
    await _box.delete(searchHistory.categorySub.uuid);
  }

  /// Clear Hive `_box`
  static Future<void> clear() async {
    await _box.clear();
    list.clear();
  }
}
