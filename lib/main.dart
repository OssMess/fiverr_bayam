import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  // print(HiveTokens.authorization);
  // await HiveTokens.clear();
  // await HiveTokens.save({
  //   'token':
  //       'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE3MDE2ODg3NzksImV4cCI6MTcwMTY5MjM3OSwicm9sZXMiOlsiUk9MRV9VU0VSIl0sInBob25lX251bWJlciI6eyJ2YWx1ZSI6IisyMzc2OTgzMDU0MTEifSwibGFzdE5hbWUiOnsidmFsdWUiOm51bGx9LCJlbWFpbCI6eyJ2YWx1ZSI6bnVsbH0sImZpcnN0TmFtZSI6eyJ2YWx1ZSI6bnVsbH0sInBob25lTnVtYmVyIjp7InZhbHVlIjoiKzIzNzY5ODMwNTQxMSJ9fQ.jy6qHwimsNd0nQ7_VlJv9ZBBXmRU8tFxI1CquLBydaNB23S30E707HUT8bKm_X_Ef_HWTI2coMjoJahFSRizLo-HvsAotziUOHgNBTW6w8iC98bvN861FNzF8X0fNz1c_A27sfXsxfSy_on0AX0fBVYF_ATfWzxzes2YyDNwuNjrmQU55G1Yp9CJTSZSzO_xM0XkIBjw8FuPacpy_d96aN0-JGLtmiyLGoCzOrXnDJofuas55B5IzBavLmNlODJBBKeQcLM4ziF-jf1ugVZPM-CBtizg2hppYed5CnPjCLm2MFC6paIt54LtwcvCCMF6CGh2bJX4ngglXnWtea5WuQ',
  //   'refreshToken':
  //       'e62f23daa49fed0b3da7395310111c36cd93d5a932e7919d5814bd9620f6d9961d169dd8c05cb8e88d591d5450d3b4053e97a6fdcc3faf6c289ea91645da5f97',
  // });
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
