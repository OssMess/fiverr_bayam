import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../tools/styles.dart';

extension BuildContextTheme<T> on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextStyle? get textThemeDisplayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get textThemeDisplayMedium =>
      Theme.of(this).textTheme.displayMedium;

  TextStyle? get textThemeDisplaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get textThemeHeadlineLarge =>
      Theme.of(this).textTheme.headlineLarge;

  TextStyle? get textThemeHeadlineMedium =>
      Theme.of(this).textTheme.headlineMedium;

  TextStyle? get textThemeTitleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get textThemeTitleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get textThemeTitleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get textThemeLabelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get textThemeBodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get appBarTitleTextStyle =>
      Theme.of(this).appBarTheme.titleTextStyle;

  TextStyle? get textThemeBodyLarge => Theme.of(this).textTheme.bodyLarge;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.background;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
}

extension BuildContextSizes<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;
}

extension BuildContextDialogs<T> on BuildContext {
  /// Show an alert adaptive dialog.
  /// - [isDismissible] : if `true, the dialog shouw be dissmisible by swiping down.
  /// - [enableDrag] : if `true, the dialog shouw be dragable.
  /// - [onComplete] : Execute after the dialog is dissmised.
  Future<void> showAdaptiveModalBottomSheet({
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
    void Function()? onComplete,
  }) async {
    await showModalBottomSheet(
      context: this,
      elevation: 0,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: builder,
    ).whenComplete(onComplete ?? () {});
  }

  /// Show a snackbar message.
  /// - [message] : a message to show on the snackbar.
  /// - [duration] : show snackbar and dismiss it after `duration` seconds. (default to 4 seconds).
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: primaryColor,
        duration: duration,
        content: Text(
          message,
          style: Styles.poppins(
            fontWeight: Styles.medium,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: AppLocalizations.of(this)!.dismiss,
          onPressed: ScaffoldMessenger.of(this).hideCurrentSnackBar,
          textColor: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension BuildContextNavigator<T> on BuildContext {
  /// Push the given [widget] or route built with [builder] onto the navigator. Executes [onPop] when the screen pops.
  // ignore: avoid_shadowing_type_parameters
  Future<T?> push<T>({
    Widget? widget,
    Widget Function(BuildContext)? builder,
    Future<T?> Function(T?)? onPop,
  }) async {
    assert((widget != null || builder != null) &&
        (widget == null || builder == null));
    if (widget != null) {
      return await Navigator.of(this)
          .push<T?>(
            MaterialPageRoute(builder: (_) => widget),
          )
          .then(onPop ?? (value) => null);
    } else if (builder != null) {
      await Navigator.of(this)
          .push<T?>(
            MaterialPageRoute(builder: builder),
          )
          .then(onPop ?? (value) => null);
    }
    throw Exception('widget != null || builder != null is not true');
  }

  /// Replace the current [widget] or route built with [builder] of the navigator by pushing the given route and then disposing the previous route once the new route has finished animating in.
  /// Executes [onPop] when the screen pops.
  Future<void> pushReplacement({
    Widget? widget,
    Widget Function(BuildContext)? builder,
    void Function(dynamic)? onPop,
  }) async {
    assert((widget != null || builder != null) &&
        (widget == null || builder == null));
    if (widget != null) {
      await Navigator.of(this)
          .pushReplacement(
            MaterialPageRoute(builder: (_) => widget),
          )
          .then(onPop ?? (value) {});
    } else if (builder != null) {
      await Navigator.of(this)
          .pushReplacement(
            MaterialPageRoute(builder: builder),
          )
          .then(onPop ?? (value) {});
    }
    throw Exception('widget != null || builder != null is not true');
  }

  /// Pop the top-most route off the navigator.
  void pop() => Navigator.of(this).pop();

  /// Calls `pop` repeatedly until the first screen.
  void popUntilFirst() =>
      Navigator.of(this).popUntil((predicate) => predicate.isFirst);
}
