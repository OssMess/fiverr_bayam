import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  PersistentTabController? controller;
  ValueNotifier<AdsViewPage>? notifierAdsViewPage =
      ValueNotifier<AdsViewPage>(AdsViewPage.myAds);

  @override
  void dispose() {
    controller = PersistentTabController(initialIndex: 0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: pageNotifier,
        ),
        ChangeNotifierProvider.value(
          value: notifierAdsViewPage,
        ),
      ],
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
          resizeToAvoidBottomInset: pageNotifier.currentPage == 3,
          extendBodyBehindAppBar: true,
          appBar: AppBar(),
          bottomNavigationBar: const CustomBottomNavigationBar(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Consumer<NotifierPage>(
            builder: (context, pageNotifier, _) {
              if (pageNotifier.currentPage == 2) {
                return CustomElevatedButton(
                  onPressed: () => context.push(
                    widget: CreateAd(
                      userSession: widget.userSession,
                      ad: null,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.create_ad,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          body: Column(
            children: [
              Consumer2<NotifierPage, ValueNotifier<AdsViewPage>?>(
                builder: (context, pageNotifier, viewPage, _) {
                  return CustomAppBarBackground(
                    type: AppBarBackgroundType.shrink,
                    appBarTitleWidget: const CustomAppBarLogo(),
                    appBarLeading: pageNotifier.currentPage == 0
                        ? AppBarActionButton(
                            icon: AwesomeIcons.magnifying_glass,
                            onTap: () async {
                              // context.push(
                              //   widget: const SearchScreen(),
                              // );
                            },
                          )
                        : null,
                    appBarActions: [
                      Builder(
                        builder: (context) {
                          if (pageNotifier.currentPage != 2 ||
                              viewPage == null) {
                            return badge.Badge(
                              badgeStyle: badge.BadgeStyle(
                                badgeColor: Styles.green,
                                elevation: 0,
                                borderSide: BorderSide(
                                  color: context.scaffoldBackgroundColor,
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
                                onTap: () => context.push(
                                  widget: const NotificationScreen(),
                                ),
                              ),
                            );
                          } else {
                            return InkResponse(
                              onTap: () {
                                if (viewPage.value == AdsViewPage.myAds) {
                                  viewPage.value = AdsViewPage.promotedAds;
                                } else {
                                  viewPage.value = AdsViewPage.myAds;
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4.sp, vertical: 8.sp),
                                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  viewPage.value == AdsViewPage.myAds
                                      ? AppLocalizations.of(context)!.promoted
                                      : AppLocalizations.of(context)!.my_ads,
                                  style: Styles.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: Styles.semiBold,
                                    color: Colors.green,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  );
                },
              ),
              Expanded(
                child: Consumer<NotifierPage>(
                  builder: (context, pageNotifier, _) {
                    return IndexedStack(
                      index: pageNotifier.currentPage,
                      children: [
                        Page1Home(userSession: widget.userSession),
                        Page2Discussions(
                          userSession: widget.userSession,
                          page: pageNotifier.currentPage,
                        ),
                        Page3CompanyAds(
                          userSession: widget.userSession,
                          page: pageNotifier.currentPage,
                        ),
                        Page4AI(
                          userSession: widget.userSession,
                          page: pageNotifier.currentPage,
                        ),
                        widget.userSession.isPerson
                            ? Page5PersonProfile(
                                userSession: widget.userSession,
                                settingsController: widget.settingsController,
                                pageNotifier: pageNotifier,
                              )
                            : Page5CompanyProfile(
                                userSession: widget.userSession,
                                settingsController: widget.settingsController,
                                pageNotifier: pageNotifier,
                              ),
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
          unselectedItemColor: context.textTheme.headlineLarge!.color,
          selectedLabelStyle: Styles.poppins(
            fontSize: 13.sp,
            fontWeight: Styles.medium,
            height: 2,
          ),
          unselectedLabelStyle: Styles.poppins(
            fontSize: 13.sp,
            fontWeight: Styles.medium,
            height: 2,
          ),
          iconSize: 22.sp,
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
