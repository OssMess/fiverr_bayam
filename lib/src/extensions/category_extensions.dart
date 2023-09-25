import 'package:flutter/material.dart';

import '../mvc/model/enums.dart';
import '../mvc/model/models_ui.dart';

extension CategoryExtensions on Category {
  String get title => Categories.titles[this]!;

  String get subtitle => Categories.subtitles[this]!;

  IconData get icon => Categories.icons[this]!;
}
