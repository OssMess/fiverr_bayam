// TODO: translate

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'extensions.dart';
import 'mvc/model/change_notifiers.dart';
import 'mvc/model/enums.dart';
import 'mvc/model/models.dart';
import 'mvc/view/model_widgets.dart';
import 'settings.dart';
import 'tools.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.userSession,
    required this.settingsController,
  });

  final UserSession userSession;
  final SettingsController settingsController;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              AppBarActionButton(
                icon: AwesomeIcons.bell,
                onTap: () {},
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
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 10.sp,
                  ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [],
                  ),
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
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor:
              Theme.of(context).textTheme.headlineMedium!.color,
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
