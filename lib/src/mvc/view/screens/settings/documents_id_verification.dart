import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class DumentsIdVerification extends StatefulWidget {
  const DumentsIdVerification({super.key});

  @override
  State<DumentsIdVerification> createState() => _DumentsIdVerificationState();
}

class _DumentsIdVerificationState extends State<DumentsIdVerification> {
  int? idType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.save,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.upload_profile_picture,
                      style: Styles.poppins(
                        fontSize: 16.sp,
                        fontWeight: Styles.semiBold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    12.heightSp,
                    Text(
                      AppLocalizations.of(context)!
                          .upload_profile_picture_subtitle,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayMedium!.color,
                      ),
                    ),
                    12.heightSp,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 45.sp),
                      decoration: BoxDecoration(
                        color: context.textTheme.headlineSmall!.color,
                        borderRadius: BorderRadius.circular(14.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularIconButton(
                            label: AppLocalizations.of(context)!.camera,
                            icon: Icons.camera_alt_outlined,
                            onTap: takeImageCamera,
                          ),
                          64.widthSp,
                          CircularIconButton(
                            label: AppLocalizations.of(context)!.upload,
                            icon: AwesomeIcons.file_outlined,
                            onTap: takeImageGallery,
                          ),
                        ],
                      ),
                    ),
                    16.heightSp,
                    Text(
                      AppLocalizations.of(context)!.choose_document_type,
                      style: Styles.poppins(
                        fontSize: 16.sp,
                        fontWeight: Styles.semiBold,
                        color: context.textTheme.displayLarge!.color,
                      ),
                    ),
                    12.heightSp,
                    Text(
                      AppLocalizations.of(context)!
                          .choose_document_type_subtitle,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: context.textTheme.displayMedium!.color,
                      ),
                    ),
                    12.heightSp,
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 12.sp,
                      runSpacing: 12.sp,
                      children: [
                        0,
                        1,
                        2,
                      ]
                          .map(
                            (index) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomChip<int?>(
                                  value: index,
                                  title: getTitle(index),
                                  groupValue: idType,
                                  onChange: (index) => setState(
                                    () {
                                      idType = index;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    12.heightSp,
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 45.sp),
                      decoration: BoxDecoration(
                        color: context.textTheme.headlineSmall!.color,
                        borderRadius: BorderRadius.circular(14.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularIconButton(
                            label: AppLocalizations.of(context)!.front,
                            icon: Icons.camera_alt_outlined,
                            onTap: takeImageCamera,
                          ),
                          64.widthSp,
                          CircularIconButton(
                            label: AppLocalizations.of(context)!.back,
                            icon: Icons.camera_alt_outlined,
                            onTap: takeImageCamera,
                          ),
                        ],
                      ),
                    ),
                    (context.viewPadding.bottom + 20.sp).height,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(int index) {
    return {
      0: AppLocalizations.of(context)!.driver_license,
      1: AppLocalizations.of(context)!.id_card,
      2: AppLocalizations.of(context)!.international_passport,
    }[index]!;
  }

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          title: AppLocalizations.of(context)!.successful,
          subtitle: AppLocalizations.of(context)!.documents_uploaded_sucess_1,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.done,
            color: Styles.green,
            onPressed: context.pop,
          ),
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Styles.poppins(
                  fontSize: 14.sp,
                  fontWeight: Styles.regular,
                  color: context.textTheme.displayLarge!.color,
                ),
                children: [
                  TextSpan(
                    text:
                        '${AppLocalizations.of(context)!.documents_uploaded_sucess_2} ',
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!
                        .documents_uploaded_sucess_3,
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      fontWeight: Styles.bold,
                      color: Styles.green,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pop();
                        context.pop();
                      },
                  ),
                ],
              ),
            ),
          ],
        );
      },
      onError: (_) {},
    );
  }

  Future<XFile?> takeImageCamera() async {
    return await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    );
  }

  Future<XFile?> takeImageGallery() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: context.textTheme.headlineSmall!.color,
              shape: BoxShape.circle,
              border: Border.all(
                color: context.scaffoldBackgroundColor,
                width: 3.sp,
              ),
            ),
            child: Icon(
              icon,
              color: context.textTheme.displayMedium!.color,
              size: 24.sp,
            ),
          ),
          4.heightSp,
          Text(
            label,
            style: Styles.poppins(
              fontSize: 14.sp,
              fontWeight: Styles.medium,
              color: context.textTheme.displayMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
