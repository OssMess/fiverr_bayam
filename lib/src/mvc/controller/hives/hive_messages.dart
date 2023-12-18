import 'dart:convert';
import 'package:hive/hive.dart';

import '../../model/models.dart';

class HiveMessages {
  /// Hive box named `messages` used to store messages.
  static late Box _box;

  /// a set of currently saved messages.
  static List<Message> _set = [];

  static const String _boxName = 'messages';

  /// Initialises and opens `_box`, load all saved user messages in `_box` to `_set` for quick access.
  static Future<void> init(UserSession userSession) async {
    _box = await Hive.openBox(_boxName);
    if (_box.isNotEmpty) {
      _set = List.from(_box.values)
          .map(
            (e) => Message.fromJson(
              e,
              null,
              userSession.uid!,
            ),
          )
          .toList();
    }
  }

  /// Save [json] to `_box`.
  static Future<void> save(Message message) async {
    _set.add(message);
    await _box.delete(message.id);
    await _box.put(
      message.id,
      message.toMap,
    );
  }

  /// Clear Hive `_box`
  static Future<void> clear() async {
    await _box.clear();
    _set.clear();
  }

  static List<Message> getListMessagesById(String discussionId) {
    var result =
        _set.where((element) => element.discussionId == discussionId).toList();
    result.sort((a, b) => a.createdAt.compareTo(b.createdAt) * -1);
    return result;
  }
}
