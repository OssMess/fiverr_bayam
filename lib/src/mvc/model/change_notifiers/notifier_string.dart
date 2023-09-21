import 'package:flutter/material.dart';

class NotifierString {
  ValueNotifier<String> notifier;

  NotifierString({required this.notifier});

  factory NotifierString.init(String value) {
    return NotifierString(notifier: ValueNotifier<String>(value));
  }

  void setValue(String value) {
    notifier.value = value;
  }

  String get value => notifier.value;
}
