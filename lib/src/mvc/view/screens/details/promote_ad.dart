import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extensions.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class PromoteAd extends StatefulWidget {
  const PromoteAd({
    super.key,
    required this.userSession,
    required this.ad,
    required this.plan,
    required this.location,
  });

  final UserSession userSession;
  final Ad ad;
  final Plan plan;
  final LatLng location;

  @override
  State<PromoteAd> createState() => _PromoteAdState();
}

class _PromoteAdState extends State<PromoteAd> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? startDate, endDate;
  String? budget;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now().add(const Duration(days: 1));
    endDate = startDate!.add(
      Duration(days: widget.plan.months * 30),
    );
    startDateController.text = DateFormat('yyyy/MM/dd').format(startDate!);
    endDateController.text = DateFormat('yyyy/MM/dd').format(endDate!);
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
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
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Form(
                  key: _keyForm,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.promote_an_ad,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.semiBold,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      16.heightSp,
                      AdBanner(
                        ad: widget.ad,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: startDateController,
                        labelText: AppLocalizations.of(context)!.start_date,
                        hintText: 'DD/MM/YYYY',
                        suffixIcon: AwesomeIcons.calendar,
                        validator: Validators.validateNotNull,
                        readOnly: true,
                        onTap: pickStartDate,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: endDateController,
                        labelText: AppLocalizations.of(context)!.end_date,
                        hintText: 'DD/MM/YYYY',
                        suffixIcon: AwesomeIcons.calendar,
                        validator: Validators.validateNotNull,
                        readOnly: true,
                        // onTap: pickEndDate,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: widget.plan.price,
                        labelText: AppLocalizations.of(context)!.budget,
                        hintText: '\$',
                        validator: Validators.validateNumberInt,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          budget = value;
                        },
                      ),
                      16.heightSp,
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          AppLocalizations.of(context)!.payment,
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            color: context.textTheme.displayMedium!.color,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.sp),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.sp),
                            border: Border.all(
                              width: 1.sp,
                              color: context.textTheme.headlineSmall!.color!,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 5.sp,
                                height: 70.sp,
                                color: Styles.green,
                              ),
                              16.widthSp,
                              Image.asset(
                                'assets/images/payment_logo.png',
                                height: 35.sp,
                                width: 35.sp,
                                fit: BoxFit.fitWidth,
                              ),
                              16.widthSp,
                              const Spacer(),
                              16.widthSp,
                              Container(
                                height: 70.sp,
                                width: 90.sp,
                                alignment: Alignment.center,
                                color: context.textTheme.headlineSmall!.color,
                                child: Text(
                                  AppLocalizations.of(context)!.edit,
                                  style: Styles.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: Styles.medium,
                                    color: Styles.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      32.heightSp,
                      CustomElevatedButton(
                        label: AppLocalizations.of(context)!.pay,
                        onPressed: next,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    Dialogs.of(context).runAsyncAction<AdPromoted>(
      future: () async {
        return await AdPromotedServices.of(widget.userSession).post(
          ad: widget.ad,
          plan: widget.plan,
          location: widget.location,
          startDate: startDate!,
          endDate: endDate!,
        );
      },
      onComplete: (adPromoted) {
        widget.userSession.listAdsPromotedMy!.insert(adPromoted!);
        Dialogs.of(context).showCustomDialog(
          header: AppLocalizations.of(context)!.ad_thankyou_header,
          title: AppLocalizations.of(context)!.success,
          subtitle: AppLocalizations.of(context)!.ad_promote_sucess_subtitle,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            color: Styles.green,
            onPressed: () {
              context.popUntilFirst();
            },
          ),
        );
      },
    );
  }

  Future<void> pickStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 120)),
    );
    if (pickedDate == null) return;
    startDate = pickedDate;
    endDate = startDate!.add(
      Duration(days: widget.plan.months * 30),
    );
    startDateController.text = DateFormat('yyyy/MM/dd').format(startDate!);
    endDateController.text = DateFormat('yyyy/MM/dd').format(endDate!);
  }

  Future<void> pickEndDate() async {
    if (startDate == null) return;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 120)),
    );
    if (pickedDate == null) return;
    endDate = pickedDate;
    endDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    return;
  }
}

class AdBanner extends StatelessWidget {
  const AdBanner({
    super.key,
    required this.ad,
  });

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedContainer(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 2.5,
            child: ad.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: ad.imagesUrl.first,
                    fit: BoxFit.cover,
                    color: context.textTheme.headlineSmall!.color,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: progress.progress,
                        color: Styles.green,
                      ),
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      padding: EdgeInsets.all(8.sp),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: context.textTheme.headlineSmall!.color,
                        borderRadius: BorderRadius.circular(14.sp),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                          vertical: 6.sp,
                        ),
                        decoration: BoxDecoration(
                          color: ad.type.toBackgroundColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          ad.type.translate(context),
                          style: Styles.poppins(
                            fontSize: 12.sp,
                            fontWeight: Styles.semiBold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          8.heightSp,
          Text(
            ad.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Styles.poppins(
              fontSize: 13.sp,
              fontWeight: Styles.semiBold,
              color: context.textTheme.displayLarge!.color,
            ),
          ),
        ],
      ),
    );
  }
}
