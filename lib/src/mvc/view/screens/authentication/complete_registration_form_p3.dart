// TODO: translate

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompleteRegistrationFormP3 extends StatefulWidget {
  const CompleteRegistrationFormP3({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationFormP3> createState() =>
      _CompleteRegistrationFormP3State();
}

class _CompleteRegistrationFormP3State
    extends State<CompleteRegistrationFormP3> {
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
        title: Image.asset(
          'assets/images/logo_transparent.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
          height: 50,
        ),
        leading: AppBarActionButton(
          icon: context.backButtonIcon,
          onTap: () => context.pop(),
        ),
      ),
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
          const CustomAppBarBackground(
            type: AppBarBackgroundType.oval,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.sp,
                  vertical: 10.sp,
                ).copyWith(bottom: context.viewPadding.bottom + 20.sp),
                child: Align(
                  heightFactor: 0.2,
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
                              color: context.textTheme.displayMedium!.color!
                                  .withOpacity(0.2),
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.photo_library_rounded,
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
                            color: context.textTheme.displayMedium!.color,
                          ),
                        ),
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

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        context.push(
          widget: CompleteRegistrationFormP4(
            userSession: widget.userSession,
          ),
        );
      },
      onError: (_) {},
    );
  }
}
