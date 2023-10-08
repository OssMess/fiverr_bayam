import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';

class CompleteRegistrationFormP5 extends StatefulWidget {
  const CompleteRegistrationFormP5({
    super.key,
    required this.userSession,
    required this.image,
  });

  final UserSession userSession;
  final XFile image;

  @override
  State<CompleteRegistrationFormP5> createState() =>
      _CompleteRegistrationFormP5State();
}

class _CompleteRegistrationFormP5State
    extends State<CompleteRegistrationFormP5> {
  XFile? file;

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
      floatingActionButton: CustomElevatedButton(
        onPressed: next,
        label: AppLocalizations.of(context)!.done,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
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
                  20.heightSp,
                  AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: EdgeInsets.all(32.sp),
                      child: CircleAvatar(
                        backgroundImage: Image.file(
                          File(
                            widget.image.path,
                          ),
                        ).image,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: context.pop,
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
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                      32.heightSp,
                    ],
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
        await AuthServices.postUserClient(
          userSession: widget.userSession,
        );
      },
      onComplete: (_) {
        context.popUntilFirst();
      },
    );
  }
}
