import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../screens.dart';

class CompleteRegistrationP1 extends StatefulWidget {
  const CompleteRegistrationP1({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationP1> createState() => _CompleteRegistrationP1State();
}

class _CompleteRegistrationP1State extends State<CompleteRegistrationP1> {
  XFile? imageFile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Row(
          children: [
            CustomElevatedButton(
              onPressed: skip,
              label: AppLocalizations.of(context)!.skip,
              color: context.textTheme.displaySmall!.color,
              fixedSize: Size(100.sp, 50.sp),
            ),
            16.widthSp,
            Expanded(
              child: CustomElevatedButton(
                onPressed: next,
                label: AppLocalizations.of(context)!.next,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomAppBarBackground(
                  type: AppBarBackgroundType.oval,
                  appBarTitleWidget: const CustomAppBarLogo(),
                  appBarLeading: AppBarActionButton(
                    icon: context.backButtonIcon,
                    onTap: () => context.pop(),
                  ),
                ),
                Positioned.fill(
                  top: Paddings.viewPadding.top +
                      kToolbarHeight +
                      0.25.sh -
                      90.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                      vertical: 10.sp,
                    ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                    child: Align(
                      heightFactor: 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 180.w,
                            height: 180.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.scaffoldBackgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: context
                                      .textTheme.headlineMedium!.color!
                                      .withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: imageFile == null
                                ? Icon(
                                    AwesomeIcons.image_gallery,
                                    size: 50.w,
                                    color: Styles.green,
                                  )
                                : CircleAvatar(
                                    radius: 85.w,
                                    backgroundImage: Image.file(
                                      File(
                                        imageFile!.path,
                                      ),
                                    ).image,
                                  ),
                          ),
                          32.heightSp,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 64.sp),
                            child: Text(
                              AppLocalizations.of(context)!.take_upload_photo,
                              textAlign: TextAlign.center,
                              style: Styles.poppins(
                                fontSize: 16.sp,
                                fontWeight: Styles.regular,
                                color: context.textTheme.displayLarge!.color,
                              ),
                            ),
                          ),
                          48.heightSp,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Future<void> takeImageGallery() async {
    await Permissions.of(context).showPhotoLibraryPermission().then(
      (value) async {
        if (value) return;
        await ImagePicker()
            .pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 1080,
          maxWidth: 1080,
        )
            .then(
          (xfile) {
            if (xfile == null) return;
            cropImage(xfile);
          },
        );
      },
    );
  }

  Future<void> takeImageCamera() async {
    await Permissions.of(context).showCameraPermission().then(
      (value) async {
        if (value) return;
        await ImagePicker()
            .pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxHeight: 1080,
          maxWidth: 1080,
        )
            .then(
          (xfile) {
            if (xfile == null) return;
            cropImage(xfile);
          },
        );
      },
    );
  }

  Future<void> next() async {
    if (imageFile == null) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.take_upload_photo,
      );
      return;
    }
    context.push(
      widget: CompleteRegistrationP2(
        userSession: widget.userSession,
        imageFile: imageFile!,
      ),
    );
  }

  Future<void> skip() async {
    await Dialogs.of(context).runAsyncAction(
      future: () async {
        await UserServices.of(widget.userSession).post(
          imageProfile: imageFile?.toFile,
        );
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          title: AppLocalizations.of(context)!.success,
          subtitle:
              AppLocalizations.of(context)!.your_information_has_been_saved,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            onPressed: context.popUntilFirst,
          ),
        );
      },
    );
  }
}
