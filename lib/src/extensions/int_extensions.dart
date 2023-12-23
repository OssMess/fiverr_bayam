import 'package:intl/intl.dart';

import '../mvc/model/enums.dart';

extension IntExtensions on int {
  /// get time format ``MM:HH` from `minutes`.
  ///
  /// - e.g. `430` in minutes is `08:13`
  String get toTimeFormat {
    return '${NumberFormat('00').format(this ~/ 60)}:${NumberFormat('00').format(this % 60)}';
  }

  AdType get toAdType => {
        0: AdType.want,
        1: AdType.sell,
        2: AdType.rent,
      }[this]!;
}
