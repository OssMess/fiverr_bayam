import 'package:flutter/material.dart';

class NotifierInt {
  ValueNotifier<int> notifier;

  NotifierInt({required this.notifier});

  factory NotifierInt.init(int value) {
    return NotifierInt(notifier: ValueNotifier<int>(value));
  }

  void setValue(int value) {
    notifier.value = value;
  }

  int get value => notifier.value;
}
