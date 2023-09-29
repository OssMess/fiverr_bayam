import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../screens.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({
    super.key,
  });

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen>
    with TickerProviderStateMixin {
  late TabController tabDurationController;
  late TabController tabTypeController;
  PlanDuration planDuration = PlanDuration.monthly;
  PlanType planType = PlanType.byCity;
  PlanName planName = PlanName.basic;

  Map<PlanDuration, Map<PlanType, Map<PlanName, int>>> prices = {
    PlanDuration.monthly: {
      PlanType.byCity: {
        PlanName.basic: 5,
        PlanName.advanced: 9,
        PlanName.unlimited: 12,
      },
      PlanType.byCountry: {
        PlanName.basic: 15,
        PlanName.advanced: 39,
        PlanName.unlimited: 99,
      },
    },
    PlanDuration.biannual: {
      PlanType.byCity: {
        PlanName.basic: 22,
        PlanName.advanced: 37,
        PlanName.unlimited: 45,
      },
      PlanType.byCountry: {
        PlanName.basic: 69,
        PlanName.advanced: 99,
        PlanName.unlimited: 145,
      },
    },
    PlanDuration.annual: {
      PlanType.byCity: {
        PlanName.basic: 35,
        PlanName.advanced: 59,
        PlanName.unlimited: 89,
      },
      PlanType.byCountry: {
        PlanName.basic: 97,
        PlanName.advanced: 142,
        PlanName.unlimited: 215,
      },
    },
  };

  @override
  void initState() {
    tabDurationController = TabController(
      length: 3,
      vsync: this,
    );
    tabTypeController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabDurationController.dispose();
    tabTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.proposed_plans,
                      style: Styles.poppins(
                        fontSize: 16.sp,
                        fontWeight: Styles.semiBold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    16.heightSp,
                    CustomTabBar(
                      controller: tabDurationController,
                      tabs: [
                        AppLocalizations.of(context)!.monthly,
                        AppLocalizations.of(context)!.biannual,
                        AppLocalizations.of(context)!.annual,
                      ],
                      onTap: (tab) {
                        switch (tab) {
                          case 0:
                            planDuration = PlanDuration.monthly;
                            break;
                          case 1:
                            planDuration = PlanDuration.biannual;
                            break;
                          case 2:
                            planDuration = PlanDuration.annual;
                            break;
                          default:
                        }
                        setState(() {});
                      },
                    ),
                    16.heightSp,
                    CustomTabBar(
                      controller: tabTypeController,
                      tabs: [
                        AppLocalizations.of(context)!.by_city,
                        AppLocalizations.of(context)!.by_country,
                      ],
                      onTap: (tab) {
                        switch (tab) {
                          case 0:
                            planType = PlanType.byCity;
                            break;
                          case 1:
                            planType = PlanType.byCountry;
                            break;
                          default:
                        }
                        setState(() {});
                      },
                    ),
                    16.heightSp,
                    PlanCard(
                      planName: PlanName.basic,
                      planDuration: planDuration,
                      planType: planType,
                      prices: prices,
                    ),
                    16.heightSp,
                    PlanCard(
                      planName: PlanName.advanced,
                      planDuration: planDuration,
                      planType: planType,
                      prices: prices,
                    ),
                    16.heightSp,
                    PlanCard(
                      planName: PlanName.unlimited,
                      planDuration: planDuration,
                      planType: planType,
                      prices: prices,
                    ),
                    (context.viewPadding.bottom + 20.sp).height,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(
          const Duration(seconds: 1),
        );
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          header: AppLocalizations.of(context)!.ad_thankyou_header,
          title: AppLocalizations.of(context)!.success,
          subtitle: AppLocalizations.of(context)!.ad_promote_sucess_subtitle,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            color: Styles.green,
            onPressed: context.pop,
          ),
        );
      },
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.planName,
    required this.planDuration,
    required this.planType,
    required this.prices,
  });

  final PlanName planName;
  final PlanDuration planDuration;
  final PlanType planType;
  final Map<PlanDuration, Map<PlanType, Map<PlanName, int>>> prices;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => context.push(widget: const CreateAd()),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.sp),
          border: Border.all(
            color: context.textTheme.headlineMedium!.color!,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    planName.translate(context),
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.regular,
                      color: context.textTheme.displayLarge!.color,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    '${prices[planDuration]![planType]![planName]!}\$',
                    style: Styles.poppins(
                      fontSize: 24.sp,
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayLarge!.color,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    planDuration.translatePlan(context),
                    style: Styles.poppins(
                      fontSize: 12.sp,
                      fontWeight: Styles.regular,
                      color: Styles.green,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                planName.translateSubtitle(context),
                style: Styles.poppins(
                  fontSize: 14.sp,
                  fontWeight: Styles.regular,
                  color: context.textTheme.displayLarge!.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
