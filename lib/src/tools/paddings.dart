import 'package:flutter/material.dart';

class Paddings {
  static late final EdgeInsets viewPadding;
  static bool initialized = false;
  static late final EdgeInsets viewInsets;
  static late final EdgeInsets padding;
  static late bool showAppBar;
  static late double appBarHeight;

  static void init(BuildContext context) {
    if (initialized) return;
    viewPadding = MediaQuery.of(context).viewPadding;
    viewInsets = MediaQuery.of(context).viewInsets;
    padding = MediaQuery.of(context).padding;
    initialized = true;
    showAppBar = true;
    appBarHeight = kToolbarHeight;
  }

  static void updateKeyboardIsVisible(bool isVisible) {
    if (isVisible) {
      showAppBar = false;
      appBarHeight = 0;
    } else {
      showAppBar = true;
      appBarHeight = kTextTabBarHeight;
    }
    // showAppBar = context.viewInsets.bottom == Paddings.viewInsets.bottom;
    // appBarHeight = showAppBar ? kToolbarHeight : 0;
  }
}
