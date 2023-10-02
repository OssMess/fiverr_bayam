import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompleteRegistrationFormP4 extends StatefulWidget {
  const CompleteRegistrationFormP4({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationFormP4> createState() =>
      _CompleteRegistrationFormP4State();
}

class _CompleteRegistrationFormP4State
    extends State<CompleteRegistrationFormP4> {
  XFile? imageFile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Row(
          children: [
            CustomElevatedButton(
              onPressed: next,
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
          CustomAppBarBackground(
            type: AppBarBackgroundType.oval,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 10.sp,
                ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                child: Align(
                  heightFactor: 0.4,
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
                              color: context.textTheme.headlineMedium!.color!
                                  .withOpacity(0.5),
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          AwesomeIcons.image_gallery,
                          size: 50.w,
                          color: Styles.green,
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
                      Text(
                        AppLocalizations.of(context)!.please_wait,
                        textAlign: TextAlign.center,
                        style: Styles.poppins(
                          fontSize: 16.sp,
                          fontWeight: Styles.regular,
                          color: context.textTheme.displayMedium!.color,
                        ),
                      ),
                      24.heightSp,
                      SpinKitRing(
                        color: context.textTheme.displayMedium!.color!,
                        size: 40.sp,
                      ),
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

  Future<void> pickImageFromGallery() async {
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
            imageFile = xfile;
          },
        );
      },
    );
  }

  Future<void> pickImageFromCamera() async {
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
            imageFile = xfile;
          },
        );
      },
    );
  }

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        context.push(
          widget: CompleteRegistrationFormP5(
            userSession: widget.userSession,
          ),
        );
      },
      onError: (_) {},
    );
  }
}
