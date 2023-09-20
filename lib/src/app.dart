import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mvc/controller/auth_wrapper.dart';
import 'settings/settings_controller.dart';

bool showSplashScreen = true;

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  void hideSplashScreen() {
    showSplashScreen = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, widget) {
        return AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
                restorationScopeId: 'app',
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                ],
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context)!.appTitle,
                theme: getLightTheme(),
                darkTheme: getDarkTheme(),
                themeMode: settingsController.themeMode,
                locale: settingsController.localeMode,
                home: AuthWrapper(
                  showSplashScreen: showSplashScreen,
                  hideSplashScreen: hideSplashScreen,
                  settingsController: settingsController,
                ));
          },
        );
      },
    );
  }

  ThemeData getLightTheme() {
    return ThemeData().copyWith(
      primaryColor: const Color(0xFF29734B),
      colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: const Color(0xFF29734B),
            secondary: const Color(0xFFffb33e),
          ),
      scaffoldBackgroundColor: Colors.white, //headline5
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      buttonTheme: const ButtonThemeData(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const Color(0xFF29734B),
        selectionColor: const Color(0xFF29734B).withAlpha(100),
        selectionHandleColor: const Color(0xFF29734B),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        //   statusBarColor: Colors.transparent,
        // ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            displayLarge: const TextStyle(color: Color(0xFF000000)),
            displayMedium:
                const TextStyle(color: Color.fromARGB(255, 106, 106, 106)),
            displaySmall: const TextStyle(color: Color(0xFFABABAB)),
            headlineMedium: const TextStyle(color: Color(0xFFDBDBDB)),
            headlineSmall: const TextStyle(color: Color(0xFFFCFCFC)),
            titleLarge: const TextStyle(color: Color(0xFFFFFFFF)),
          ),
    );
  }

  ThemeData getDarkTheme() {
    return ThemeData().copyWith(
      primaryColor: const Color(0xFF29734B),
      colorScheme: ThemeData.light().colorScheme.copyWith(
            secondary: const Color(0xFFffb33e),
          ),
      scaffoldBackgroundColor: Colors.black,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      buttonTheme: const ButtonThemeData(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: const Color(0xFF29734B),
        selectionColor: const Color(0xFF29734B).withAlpha(100),
        selectionHandleColor: const Color(0xFF29734B),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        //   statusBarColor: Colors.transparent,
        // ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: const TextStyle(color: Color(0xFF000000)),
            headlineSmall:
                const TextStyle(color: Color.fromARGB(255, 86, 86, 86)),
            headlineMedium: const TextStyle(color: Color(0xFFABABAB)),
            displaySmall: const TextStyle(color: Color(0xFFDBDBDB)),
            displayMedium: const TextStyle(color: Color(0xFFFCFCFC)),
            displayLarge: const TextStyle(color: Color(0xFFFFFFFF)),
          ),
    );
  }
}
