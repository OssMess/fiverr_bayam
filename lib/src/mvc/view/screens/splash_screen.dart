import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badge;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';
import '../../model/models.dart';
import '../model_widgets.dart';

/// Splash screen, it shows when the app is opened and is still preparing data
class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.userSession,
    required this.isLoading,
    this.error,
  });

  /// user session
  final UserSession userSession;

  /// show the splash screen as a loading indicator
  final bool isLoading;

  /// if there was an error, show report button
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: context.primaryColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/logo_transparent.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              height: 200.h,
            ),
            if (error != null) ...[
              const Spacer(flex: 2),
              const Spacer(),
              badge.Badge(
                badgeStyle: const badge.BadgeStyle(
                  badgeColor: Colors.transparent,
                  elevation: 0,
                ),
                position: badge.BadgePosition.topEnd(
                  top: -8.sp,
                  end: -8.sp,
                ),
                badgeAnimation: const badge.BadgeAnimation.scale(
                  animationDuration: Duration(milliseconds: 100),
                  disappearanceFadeAnimationDuration:
                      Duration(milliseconds: 50),
                ),
                badgeContent: Icon(
                  Icons.bug_report,
                  size: 25.sp,
                  color: Styles.red,
                ),
                child: Icon(
                  Icons.warning_amber,
                  size: 90.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.sp),
              Text(
                AppLocalizations.of(context)!.oops,
                style: Styles.poppins(
                  fontSize: 22.sp,
                  fontWeight: Styles.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.sp),
                child: Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.medium,
                    color: context.textThemeDisplaySmall!.color,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              CustomElevatedButton(
                label: AppLocalizations.of(context)!.logout,
                onPressed: userSession.onSignout,
              ),
            ],
            const Spacer(),
            FutureBuilder(
              future: PackageInfo.fromPlatform().then((value) => value.version),
              builder: (context, snapshot) {
                return SizedBox(
                  height: 20.sp,
                  child: snapshot.hasData
                      ? Text(
                          'Version: ${snapshot.data!}',
                          style: Styles.poppins(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: Styles.medium,
                          ),
                        )
                      : null,
                );
              },
            ),
            SizedBox(height: Platform.isIOS ? 20.sp : 10.sp),
          ],
        ),
      ),
    );
  }
}
