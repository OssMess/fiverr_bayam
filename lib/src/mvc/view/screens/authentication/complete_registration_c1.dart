import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';
import '../../tiles.dart';

class CompleteRegistrationPageC1 extends StatefulWidget {
  const CompleteRegistrationPageC1({
    super.key,
    required this.userSession,
    required this.geocodingLocation,
  });

  final UserSession userSession;
  final GeoCodingLocation? geocodingLocation;

  @override
  State<CompleteRegistrationPageC1> createState() =>
      _CompleteRegistrationPageC1State();
}

class _CompleteRegistrationPageC1State
    extends State<CompleteRegistrationPageC1> {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  TextEditingController dateController = TextEditingController();
  String? companyName;
  XFile? imageProfile;
  Set<XFile> imageCompany = {};
  List<String> imagesUrl = [];
  String? uniqueRegisterNumber;
  String? streetAddress;
  String? city;
  String? postalCode;
  String? country;
  String? region;
  DateTime? startupDate;

  @override
  void initState() {
    companyName = widget.userSession.companyName;
    uniqueRegisterNumber = widget.userSession.uniqueRegisterNumber;
    streetAddress = widget.userSession.streetAddress ??
        widget.geocodingLocation?.streetAddress;
    postalCode =
        widget.userSession.postalCode ?? widget.geocodingLocation?.postalCode;
    try {
      city = widget.userSession.city ??
          widget.userSession.cities?.first.name ??
          widget.geocodingLocation?.city;
    } catch (e) {
      city = widget.geocodingLocation?.city;
    }
    try {
      country = widget.userSession.country ??
          widget.userSession.countries?.first.name ??
          widget.geocodingLocation?.country;
    } catch (e) {
      country = widget.geocodingLocation?.country;
    }
    region = widget.userSession.region;
    startupDate = DateTime.tryParse(widget.userSession.birthDate ?? '');
    dateController.text = widget.userSession.birthDate ?? '';
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitle: AppLocalizations.of(context)!.company_details,
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                autovalidateMode: AutovalidateMode.disabled,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.sp,
                    vertical: 10.sp,
                  ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormFieldBounded(
                        initialValue: companyName,
                        labelText:
                            AppLocalizations.of(context)!.company_name_label,
                        hintText:
                            AppLocalizations.of(context)!.company_name_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          companyName = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      StatefulBuilder(
                        builder: (context, setState) {
                          return InkResponse(
                            onTap: () async {
                              await Functions.of(context).pickImage(
                                source: ImageSource.gallery,
                                onPick: (xfile) {
                                  setState(() {
                                    imageProfile = xfile;
                                  });
                                },
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 0.15.sh,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.textTheme.headlineSmall!.color!,
                                borderRadius: BorderRadius.circular(14.sp),
                                image: imageProfile != null
                                    ? DecorationImage(
                                        image: Image.file(imageProfile!.toFile)
                                            .image,
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 3,
                                    sigmaY: 3,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(12.sp),
                                    decoration: BoxDecoration(
                                      color: context.scaffoldBackgroundColor
                                          .withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.circular(12.sp),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          AwesomeIcons.cloud_arrow_up,
                                          color: Styles.green,
                                          size: 40.sp,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .upload_company_profile_image,
                                          textAlign: TextAlign.center,
                                          style: Styles.poppins(
                                            fontSize: 12.sp,
                                            fontWeight: Styles.semiBold,
                                            color: Styles.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      16.heightSp,
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 12.sp),
                            decoration: BoxDecoration(
                              color: context.textTheme.headlineSmall!.color!,
                              borderRadius: BorderRadius.circular(14.sp),
                            ),
                            height: 0.16.sh,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .upload_company_gallery_images,
                                    textAlign: TextAlign.center,
                                    style: Styles.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: Styles.semiBold,
                                      color: Styles.green,
                                    ),
                                  ),
                                ),
                                8.heightSp,
                                Expanded(
                                  child: ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.sp),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Builder(
                                      builder: (context) {
                                        if (index < imageCompany.length) {
                                          return ImageCard(
                                            index: index,
                                            image: Image.file(
                                              imageCompany
                                                  .elementAt(index)
                                                  .toFile,
                                            ).image,
                                            onDeleteImage: (value) =>
                                                setState(() {
                                              imageCompany.remove(
                                                imageCompany.elementAt(index),
                                              );
                                            }),
                                          );
                                        } else if (index <
                                            imageCompany.length +
                                                imagesUrl.length) {
                                          return ImageCard(
                                            index: index,
                                            image: CachedNetworkImageProvider(
                                              imagesUrl.elementAt(
                                                index - imageCompany.length,
                                              ),
                                            ),
                                            onDeleteImage: (value) => setState(
                                              () {
                                                imagesUrl.removeAt(
                                                  index - imageCompany.length,
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return ImageCard(
                                            index: index,
                                            onAddImages: (elements) =>
                                                setState(() {
                                              imageCompany.addAll(elements);
                                            }),
                                          );
                                        }
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        8.widthSp,
                                    itemCount: imageCompany.length +
                                        imagesUrl.length +
                                        1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: uniqueRegisterNumber,
                        labelText: AppLocalizations.of(context)!.reg_num_label,
                        hintText: AppLocalizations.of(context)!.reg_num_hint,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          uniqueRegisterNumber = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: dateController,
                        labelText:
                            AppLocalizations.of(context)!.company_startup_label,
                        hintText: AppLocalizations.of(context)!.date_format,
                        keyboardType: TextInputType.datetime,
                        validator: Validators.validateNotNull,
                        textInputAction: TextInputAction.next,
                        suffixIcon: AwesomeIcons.calendar,
                        onTap: () => pickDate(dateController, startupDate).then(
                          (value) {
                            if (value == null) return;
                            startupDate = value;
                          },
                        ),
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: streetAddress,
                        labelText:
                            AppLocalizations.of(context)!.street_adr_label,
                        hintText: AppLocalizations.of(context)!.street_adr_hint,
                        keyboardType: TextInputType.streetAddress,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          streetAddress = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.town_label,
                        hintText: AppLocalizations.of(context)!.town_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          city = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: postalCode,
                        labelText: AppLocalizations.of(context)!.zip_label,
                        hintText: AppLocalizations.of(context)!.zip_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        onSaved: (value) {
                          postalCode = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: city,
                        labelText: AppLocalizations.of(context)!.state_label,
                        hintText: AppLocalizations.of(context)!.state_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        // suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          region = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        initialValue: country,
                        labelText: AppLocalizations.of(context)!.country_label,
                        hintText: AppLocalizations.of(context)!.country_hint,
                        keyboardType: TextInputType.name,
                        validator: Validators.validateNotNull,
                        // suffixIcon: Icons.arrow_drop_down,
                        onSaved: (value) {
                          country = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      32.heightSp,
                      CustomElevatedButton(
                        onPressed: next,
                        label: AppLocalizations.of(context)!.continu,
                      ),
                      16.heightSp,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Styles.poppins(
                            fontSize: 14.sp,
                            fontWeight: Styles.medium,
                            color: Styles.green,
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.reg_terms_1,
                            ),
                            TextSpan(
                              text:
                                  ' ${AppLocalizations.of(context)!.reg_terms_2} ',
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: Styles.green,
                                textDecoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.push(widget: const PrivacyPolicy()),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.reg_terms_3,
                            ),
                            TextSpan(
                              text:
                                  ' ${AppLocalizations.of(context)!.reg_terms_4}',
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: Styles.green,
                                textDecoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.push(widget: const PrivacyPolicy()),
                            ),
                            const TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate(
    TextEditingController controller,
    DateTime? initialDate,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.parse('1950-01-01'),
      lastDate: DateTime.now(),
    );
    if (pickedDate == null) return null;
    controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    return pickedDate;
  }

  Future<void> next() async {
    if (imageProfile == null) {
      context.showSnackBar(
        message: AppLocalizations.of(context)!.pick_company_image_profile,
      );
      return;
    }
    if (imageCompany.isEmpty) {
      context.showSnackBar(
        message: AppLocalizations.of(context)!.pick_company_images_gallery,
      );
      return;
    }
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    widget.userSession.companyName = companyName;
    widget.userSession.uniqueRegisterNumber = uniqueRegisterNumber;
    widget.userSession.streetAddress = streetAddress;
    widget.userSession.postalCode = postalCode;
    widget.userSession.city = city;
    widget.userSession.country = country;
    widget.userSession.region = region;
    widget.userSession.birthDate = dateController.text;
    context.push(
      widget: CompletePreferences(
        userSession: widget.userSession,
        accountType: AccountType.company,
        imageProfile: imageProfile,
        imageCompany: imageCompany,
      ),
    );
  }
}
