// TODO: translate

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badges/badges.dart' as badge;

import '../../../../extensions.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../settings.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userSession,
    required this.settingsController,
  });

  final UserSession userSession;
  final SettingsController settingsController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotifierPage pageNotifier = NotifierPage();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: pageNotifier,
      child: WillPopScope(
        onWillPop: () {
          if (pageNotifier.currentPage != 0) {
            pageNotifier.setCurrentPage(0);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Image.asset(
              'assets/images/logo_transparent.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              height: 50,
            ),
            leading: AppBarActionButton(
              icon: AwesomeIcons.bars_sort,
              onTap: () {},
            ),
            actions: [
              badge.Badge(
                badgeStyle: badge.BadgeStyle(
                  badgeColor: Styles.green,
                  elevation: 0,
                  borderSide: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2.sp,
                  ),
                  padding: EdgeInsets.all(6.sp),
                ),
                badgeAnimation: const badge.BadgeAnimation.scale(
                  toAnimate: false,
                ),
                position: badge.BadgePosition.topEnd(
                  top: 6.sp,
                  end: 12.sp,
                ),
                showBadge: true,
                badgeContent: Text(
                  '1',
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.semiBold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                child: AppBarActionButton(
                  icon: AwesomeIcons.bell,
                  onTap: () {},
                ),
              )
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
          body: Column(
            children: [
              const CustomAppBarBackground(
                type: AppBarBackgroundType.shrink,
              ),
              Expanded(
                child: Consumer<NotifierPage>(
                  builder: (context, pageNotifier, _) {
                    return IndexedStack(
                      index: pageNotifier.currentPage,
                      children: [
                        Page1Home(userSession: widget.userSession),
                        Page2Messages(userSession: widget.userSession),
                        Page3Ads(userSession: widget.userSession),
                        Page4AI(userSession: widget.userSession),
                        Page5Profile(userSession: widget.userSession),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NotifierPage>(
      builder: (context, pageNotifier, _) {
        return BottomNavigationBar(
          selectedItemColor: context.primaryColor,
          unselectedItemColor: context.textTheme.headlineMedium!.color,
          selectedLabelStyle: Styles.poppins(
            fontSize: 11.sp,
            fontWeight: Styles.medium,
            height: 2.5,
          ),
          unselectedLabelStyle: Styles.poppins(
            fontSize: 11.sp,
            fontWeight: Styles.medium,
            height: 2.5,
          ),
          iconSize: 20.sp,
          elevation: 30,
          currentIndex: pageNotifier.currentPage,
          onTap: pageNotifier.setCurrentPage,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: context.scaffoldBackgroundColor,
          items: [
            (
              AwesomeIcons.home_blank,
              AppLocalizations.of(context)!.home,
            ),
            (
              AwesomeIcons.chat,
              AppLocalizations.of(context)!.messages,
            ),
            (
              AwesomeIcons.ads,
              AppLocalizations.of(context)!.ads,
            ),
            (
              AwesomeIcons.robot,
              AppLocalizations.of(context)!.ai_assistant,
            ),
            (
              AwesomeIcons.user_rounded,
              AppLocalizations.of(context)!.profile,
            ),
          ]
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.$1,
                  ),
                  label: e.$2,
                ),
              )
              .toList(),
        );
      },
    );
  }
}
