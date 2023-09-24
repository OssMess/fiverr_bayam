import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

class CompleteRegistrationFormP2 extends StatefulWidget {
  const CompleteRegistrationFormP2({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationFormP2> createState() =>
      _CompleteRegistrationFormP2State();
}

class _CompleteRegistrationFormP2State
    extends State<CompleteRegistrationFormP2> {
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
        title: Text(
          AppLocalizations.of(context)!.tax_details,
        ),
        leading: AppBarActionButton(
          icon: context.backButtonIcon,
          onTap: () => context.pop(),
        ),
      ),
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.next,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          const CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
          ),
          Expanded(
            child: SingleChildScrollView(
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
                      child: Row(
                        children: [
                          Icon(
                            AwesomeIcons.id_card,
                            size: 40.sp,
                            color: Styles.green,
                          ),
                          16.widthSp,
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.person_upload_id,
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.medium,
                                color: Styles.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.heightSp,
                    InkResponse(
                      onTap: () async {
                        if (await Permissions.of(context)
                            .showPhotoLibraryPermission()) return;
                      },
                      child: Container(
                        width: double.infinity,
                        height: 0.25.sh,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.textTheme.displayLarge!.color!,
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: CustomTextButton(
                          button: ModelTextButton(
                            label: 'Scan ID card',
                            fontColor: context.scaffoldBackgroundColor,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
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
          widget: CompleteRegistrationFormP3(
            userSession: widget.userSession,
          ),
        );
      },
      onError: (_) {},
    );
  }
}
