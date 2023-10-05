import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../model/enums.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';
import '../../model_widgets_screens.dart';

class DocumentsPersonVerification extends StatefulWidget {
  const DocumentsPersonVerification({super.key});

  @override
  State<DocumentsPersonVerification> createState() =>
      _DocumentsPersonVerificationState();
}

class _DocumentsPersonVerificationState
    extends State<DocumentsPersonVerification> {
  int? idType;

  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
                    SettingsHeaderSubtitle(
                      title:
                          AppLocalizations.of(context)!.upload_profile_picture,
                      subtitle: AppLocalizations.of(context)!
                          .upload_profile_picture_subtitle,
                    ),
                    12.heightSp,
                    if (imageFile != null)
                      InkResponse(
                        onTap: () => setState(() {
                          imageFile = null;
                        }),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.5.sp),
                            child: CircleAvatar(
                              radius: 80.sp,
                              backgroundImage: Image.file(
                                File(
                                  imageFile!.path,
                                ),
                              ).image,
                            ),
                          ),
                        ),
                      ),
                    if (imageFile == null)
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

  Future<void> cropImage(XFile file) async {
    await ImageCropper().cropImage(
      sourcePath: file.path,
      maxWidth: 512,
      maxHeight: 512,
      compressFormat: ImageCompressFormat.png,
      cropStyle: CropStyle.circle,
      aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
          activeControlsWidgetColor: Theme.of(context).primaryColor,
          toolbarTitle: 'Cropper',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1,
          title: 'Cropper',
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          aspectRatioLockDimensionSwapEnabled: true,
          rotateButtonsHidden: true,
        ),
      ],
    ).then(
      (file) {
        if (file == null) return;
        setState(() {
          imageFile = XFile(file.path);
        });
      },
    );
  }

  Future<void> takeImageCamera() async {
    if (await Permissions.of(context).showCameraPermission()) {
      return;
    }
    return await ImagePicker()
        .pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    )
        .then(
      (xfile) {
        if (xfile == null) return;
        cropImage(xfile);
      },
    );
  }

  Future<void> takeImageGallery() async {
    if (await Permissions.of(context).showPhotoLibraryPermission()) {
      return;
    }
    return await ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    )
        .then(
      (xfile) {
        if (xfile == null) return;
        cropImage(xfile);
      },
    );
  }
}
