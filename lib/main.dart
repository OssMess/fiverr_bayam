import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'src/app.dart';
import 'src/mvc/controller/hives.dart';
import 'src/mvc/model/models.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SettingsController settingsController =
      SettingsController(SettingsService());
  await settingsController.loadSettings();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  await HiveCookies.init();
  await HiveTokens.init();
  await HiveSearchHistory.init();
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('62db6cad-0504-4ccf-8fc9-6cefc05d7e8f');
  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  UserSession userSession = UserSession.initAwaiting();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: userSession,
        ),
      ],
      child: MyApp(
        settingsController: settingsController,
      ),
    ),
  );
}
