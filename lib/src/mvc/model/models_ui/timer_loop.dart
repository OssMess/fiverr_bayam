import 'dart:async';

import 'package:flutter/material.dart';

class TimerLoop with ChangeNotifier {
  final int milliseconds;
  int durationMilliseconds = 0;

  Timer? _timer;

  TimerLoop({this.milliseconds = 1000});

  bool get isActive => _timer?.isActive == true;

  Duration get duration => Duration(milliseconds: durationMilliseconds);

  void run() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(Duration(milliseconds: milliseconds), (timer) {
      addTime();
    });
  }

  void addTime() {
    if (!isActive) return;
    durationMilliseconds += milliseconds;
    notifyListeners();
  }

  void cancel() {
    _timer?.cancel();
    durationMilliseconds = 0;
    notifyListeners();
  }
}
