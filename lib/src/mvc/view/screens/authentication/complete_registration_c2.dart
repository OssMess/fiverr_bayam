import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';

class CompleteRegistrationC2 extends StatefulWidget {
  const CompleteRegistrationC2({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteRegistrationC2> createState() => _CompleteRegistrationC2State();
}

class _CompleteRegistrationC2State extends State<CompleteRegistrationC2> {
  XFile? file;

  @override
  void dispose() {
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
            appBarTitle: AppLocalizations.of(context)!.tax_details,
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: () => context.pop(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
              vertical: 10.sp,
            ),
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
                        AwesomeIcons.folder,
                        size: 40.sp,
                        color: Styles.green,
                      ),
                      16.widthSp,
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!
                              .company_upload_tax_documents,
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
                      color: context.textTheme.headlineSmall!.color!,
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          AwesomeIcons.cloud_arrow_up,
                          color: Styles.green,
                          size: 40.sp,
                        ),
                        Text(
                          AppLocalizations.of(context)!.upload_documents,
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
                54.heightSp,
                CustomElevatedButton(
                  onPressed: next,
                  label: AppLocalizations.of(context)!.done,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> next() async {
    Dialogs.of(context).runAsyncAction(
      future: () async {
        await AuthServices.postUserCompany(
          userSession: widget.userSession,
        );
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          title: AppLocalizations.of(context)!.success,
          subtitle:
              AppLocalizations.of(context)!.your_information_has_been_saved,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            onPressed: () {
              context.popUntilFirst();
            },
          ),
        );
      },
      onError: (_) {},
    );
  }
}
