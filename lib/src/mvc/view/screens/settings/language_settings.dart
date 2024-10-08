import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../../settings.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/list_models.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({
    super.key,
    required this.userSession,
    required this.settingsController,
  });

  final UserSession userSession;
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: AnimatedBuilder(
                animation: settingsController,
                builder: (context, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      16.heightSp,
                      CustomElevatedListTile(
                        title: AppLocalizations.of(context)!.english,
                        trailing: Icon(
                          Icons.check,
                          size: 24.sp,
                          color: Styles.green,
                        ),
                        showTrailing:
                            settingsController.localeMode.languageCode == 'en',
                        padding: EdgeInsets.all(24.sp),
                        onTap: () => updateLocale(context, 'en'),
                      ),
                      16.heightSp,
                      CustomElevatedListTile(
                        title: AppLocalizations.of(context)!.french,
                        trailing: Icon(
                          Icons.check,
                          size: 24.sp,
                          color: Styles.green,
                        ),
                        showTrailing:
                            settingsController.localeMode.languageCode == 'fr',
                        padding: EdgeInsets.all(24.sp),
                        onTap: () => updateLocale(context, 'fr'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateLocale(BuildContext context, String locale) async {
    await settingsController.updateLocaleMode(Locale(locale));
    // ignore: use_build_context_synchronously
    ListFAQ.init(context);
    await UserServices.of(userSession).post(
      // ignore: use_build_context_synchronously
      context,
      locale: locale,
    );
  }
}
