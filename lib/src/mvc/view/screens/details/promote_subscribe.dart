import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/list_models/list_plans.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../screens.dart';

final Map<PlanDuration, int> months = {
  PlanDuration.monthly: 1,
  PlanDuration.biannual: 6,
  PlanDuration.annual: 12,
};

class PromoteSubscribe extends StatefulWidget {
  const PromoteSubscribe({
    super.key,
    required this.userSession,
    required this.ad,
  });

  final UserSession userSession;
  final Ad ad;

  @override
  State<PromoteSubscribe> createState() => _PromoteSubscribeState();
}

class _PromoteSubscribeState extends State<PromoteSubscribe>
    with TickerProviderStateMixin {
  late TabController tabDurationController;
  late TabController tabTypeController;
  PlanDuration planDuration = PlanDuration.monthly;
  PlanPlace planPlace = PlanPlace.byCity;

  PlanType planType = PlanType.basic;

  Iterable<Plan> setPlans = {};

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
    widget.userSession.listPlans!.initData(callGet: true).then(
      (_) {
        setState(() {
          setPlans =
              widget.userSession.listPlans!.mapPlans(planDuration, planPlace);
        });
      },
    );
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
          ChangeNotifierProvider.value(
            value: widget.userSession.listPlans,
            child: Consumer<ListPlans>(
              builder: (context, listPlans, _) {
                if (listPlans.isNull) {
                  return const CustomLoadingIndicator(
                    isSliver: false,
                  );
                }
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Column(
                        children: [
                          // Title
                          Text(
                            AppLocalizations.of(context)!.proposed_plans,
                            style: Styles.poppins(
                              fontSize: 16.sp,
                              fontWeight: Styles.semiBold,
                              color: context.textTheme.displayLarge!.color,
                            ),
                          ),
                          16.heightSp,
                          // Plan durations
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
                              setState(() {
                                setPlans = widget.userSession.listPlans!
                                    .mapPlans(planDuration, planPlace);
                              });
                            },
                          ),
                          16.heightSp,
                          // Plan place
                          CustomTabBar(
                            controller: tabTypeController,
                            tabs: [
                              AppLocalizations.of(context)!.by_city,
                              AppLocalizations.of(context)!.by_country,
                            ],
                            onTap: (tab) {
                              switch (tab) {
                                case 0:
                                  planPlace = PlanPlace.byCity;
                                  break;
                                case 1:
                                  planPlace = PlanPlace.byCountry;
                                  break;
                                default:
                              }
                              setState(() {
                                setPlans = widget.userSession.listPlans!
                                    .mapPlans(planDuration, planPlace);
                              });
                            },
                          ),
                          16.heightSp,
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: setPlans.length,
                            separatorBuilder: (_, __) => 16.heightSp,
                            itemBuilder: (context, index) =>
                                Builder(builder: (context) {
                              Plan plan = setPlans.elementAt(index);
                              return PlanCard(
                                userSession: widget.userSession,
                                ad: widget.ad,
                                plan: plan,
                              );
                            }),
                          ),
                          (context.viewPadding.bottom + 20.sp).height,
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.userSession,
    required this.ad,
    required this.plan,
  });

  final UserSession userSession;
  final Ad ad;
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () async {
        Permissions.of(context).showLocationPermission().then(
          (value) {
            if (value) return;
            context.push(
              widget: PromoteLocation(
                userSession: userSession,
                ad: ad,
                plan: plan,
              ),
            );
          },
        );
      },
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
              width: 120.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.type.translate(context),
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.regular,
                      color: context.textTheme.displayLarge!.color,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    plan.price,
                    style: Styles.poppins(
                      fontSize: 24.sp,
                      fontWeight: Styles.medium,
                      color: context.textTheme.displayLarge!.color,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    plan.duration.translatePlan(context),
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
                plan.description,
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
