import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';

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
  XFile? file;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const CustomAppBarLogo(),
        leading: AppBarActionButton(
          icon: context.backButtonIcon,
          onTap: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.sp,
                vertical: 10.sp,
              ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: Styles.green[50],
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.take_selfie,
                      textAlign: TextAlign.center,
                      style: Styles.poppins(
                        fontSize: 14.sp,
                        fontWeight: Styles.medium,
                        color: Styles.green,
                      ),
                    ),
                  ),
                  16.heightSp,
                  Expanded(
                    child: InkResponse(
                      onTap: () async {
                        if (await Permissions.of(context)
                            .showPhotoLibraryPermission()) return;
                      },
                      child: Container(
                        width: double.infinity,
                        height: 0.25.sh,
                        decoration: BoxDecoration(
                          color: context.textTheme.displayLarge!.color!,
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              mini: true,
                              child: Icon(
                                AwesomeIcons.rotate_right,
                                color: Styles.green,
                                size: 24.sp,
                              ),
                            ),
                            8.heightSp,
                            Text(
                              AppLocalizations.of(context)!.retake,
                              style: Styles.poppins(
                                fontSize: 12.sp,
                                fontWeight: Styles.semiBold,
                                color: Colors.white,
                              ),
                            ),
                            32.heightSp,
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.heightSp,
                  CustomElevatedButton(
                    onPressed: next,
                    label: AppLocalizations.of(context)!.done,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {},
      onError: (_) {},
    );
  }
}
