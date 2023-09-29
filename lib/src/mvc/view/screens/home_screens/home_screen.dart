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
  ValueNotifier<CompanyViewPage>? notifierCompanyViewPage;

  @override
  void initState() {
    super.initState();
    if (widget.userSession.isCompany) {
      notifierCompanyViewPage =
          ValueNotifier<CompanyViewPage>(CompanyViewPage.myAds);
    }
  }

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
          value: notifierCompanyViewPage,
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
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          floatingActionButton:
              Consumer2<NotifierPage, ValueNotifier<CompanyViewPage>?>(
                  builder: (context, currentPage, companyViewPage, _) {
            if (companyViewPage == null ||
                currentPage.currentPage != 2 ||
                companyViewPage.value == CompanyViewPage.promotedAds) {
              return const SizedBox.shrink();
            }
            return CustomElevatedButton(
              onPressed: () => context.push(widget: const SubscribeScreen()),
              label: AppLocalizations.of(context)!.create_ad,
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const CustomAppBarLogo(),
            leading: AppBarActionButton(
              icon: AwesomeIcons.bars_sort,
              onTap: () {},
            ),
            actions: [
              Consumer2<NotifierPage, ValueNotifier<CompanyViewPage>?>(
                builder: (context, currentPage, companyViewPage, _) {
                  if (currentPage.currentPage != 2 || companyViewPage == null) {
                    return badge.Badge(
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
                    );
                  } else {
                    return InkResponse(
                      onTap: () {
                        if (companyViewPage.value == CompanyViewPage.myAds) {
                          companyViewPage.value = CompanyViewPage.promotedAds;
                        } else {
                          companyViewPage.value = CompanyViewPage.myAds;
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
                          companyViewPage.value == CompanyViewPage.myAds
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
                        widget.userSession.isPerson
                            ? Page3PersonAds(userSession: widget.userSession)
                            : Page3CompanyAds(userSession: widget.userSession),
                        Page4AI(userSession: widget.userSession),
                        widget.userSession.isPerson
                            ? Page5PersonProfile(
                                userSession: widget.userSession,
                                settingsController: widget.settingsController,
                              )
                            : Page5CompanyProfile(
                                userSession: widget.userSession,
                                settingsController: widget.settingsController,
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
    // return Scaffold(
    //   body: PersistentTabView(
    //     context,
    //     appBar: CustomAppBarBackground(
    //       type: AppBarBackgroundType.shrink,
    //       appBarTitleWidget: Image.asset(
    //         'assets/images/logo_transparent.png',
    //         fit: BoxFit.contain,
    //         alignment: Alignment.center,
    //         height: 50,
    //       ),
    //       appBarLeading: AppBarActionButton(
    //         icon: AwesomeIcons.bars_sort,
    //         onTap: () {},
    //       ),
    //       appBarActions: [
    //         badge.Badge(
    //           badgeStyle: badge.BadgeStyle(
    //             badgeColor: Styles.green,
    //             elevation: 0,
    //             borderSide: BorderSide(
    //               color: Theme.of(context).scaffoldBackgroundColor,
    //               width: 2.sp,
    //             ),
    //             padding: EdgeInsets.all(6.sp),
    //           ),
    //           badgeAnimation: const badge.BadgeAnimation.scale(
    //             toAnimate: false,
    //           ),
    //           position: badge.BadgePosition.topEnd(
    //             top: 6.sp,
    //             end: 12.sp,
    //           ),
    //           showBadge: true,
    //           badgeContent: Text(
    //             '1',
    //             style: Styles.poppins(
    //               fontSize: 12.sp,
    //               fontWeight: Styles.semiBold,
    //               color: Colors.white,
    //               height: 1.2,
    //             ),
    //           ),
    //           child: AppBarActionButton(
    //             icon: AwesomeIcons.bell,
    //             onTap: () {},
    //           ),
    //         )
    //       ],
    //     ),
    //     controller: controller,
    //     popAllScreensOnTapAnyTabs: true,
    //     screens: [
    //       Page1Home(userSession: widget.userSession),
    //       Page2Messages(userSession: widget.userSession),
    //       Page3Ads(userSession: widget.userSession),
    //       Page4AI(userSession: widget.userSession),
    //       Page5Profile(userSession: widget.userSession),
    //     ],
    //     items: [
    //       (
    //         AwesomeIcons.home_blank,
    //         AppLocalizations.of(context)!.home,
    //       ),
    //       (
    //         AwesomeIcons.chat,
    //         AppLocalizations.of(context)!.messages,
    //       ),
    //       (
    //         AwesomeIcons.ads,
    //         AppLocalizations.of(context)!.ads,
    //       ),
    //       (
    //         AwesomeIcons.robot,
    //         AppLocalizations.of(context)!.ai_assistant,
    //       ),
    //       (
    //         AwesomeIcons.user_rounded,
    //         AppLocalizations.of(context)!.profile,
    //       ),
    //     ]
    //         .map(
    //           (e) => PersistentBottomNavBarItem(
    //             icon: Icon(
    //               e.$1,
    //             ),
    //             title: e.$2,
    //             iconSize: 20.sp,
    //             activeColorPrimary: context.primaryColor,
    //             inactiveColorPrimary: context.textTheme.headlineMedium!.color,
    //             textStyle: Styles.poppins(
    //               fontSize: 11.sp,
    //               fontWeight: Styles.medium,
    //               height: 2.5,
    //             ),
    //           ),
    //         )
    //         .toList(),
    //     confineInSafeArea: true,
    //     backgroundColor: context.scaffoldBackgroundColor,
    //     handleAndroidBackButtonPress: true,
    //     resizeToAvoidBottomInset: true,
    //     stateManagement: true,
    //     hideNavigationBarWhenKeyboardShows: false,
    //     decoration: NavBarDecoration(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(14.sp)),
    //       colorBehindNavBar: context.textTheme.headlineSmall!.color!,
    //     ),
    //     popAllScreensOnTapOfSelectedTab: true,
    //     popActionScreens: PopActionScreensType.all,
    //     itemAnimationProperties: const ItemAnimationProperties(
    //       duration: Duration(milliseconds: 200),
    //       curve: Curves.ease,
    //     ),
    //     screenTransitionAnimation: const ScreenTransitionAnimation(
    //       animateTabTransition: true,
    //       curve: Curves.ease,
    //       duration: Duration(milliseconds: 200),
    //     ),
    //     navBarStyle: NavBarStyle.style6,
    //     navBarHeight: 60,
    //   ),
    // );
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
