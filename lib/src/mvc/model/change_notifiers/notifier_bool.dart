import 'package:flutter/material.dart';

class NotifierBool {
  ValueNotifier<bool> notifier;

  NotifierBool({required this.notifier});

  factory NotifierBool.init(bool value) {
    return NotifierBool(notifier: ValueNotifier<bool>(value));
  }

  void setValue(bool value) {
    notifier.value = value;
  }

  bool get value => notifier.value;
}
