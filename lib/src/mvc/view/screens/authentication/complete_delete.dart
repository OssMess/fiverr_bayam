//TODO delete
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

class CompleteDelete extends StatefulWidget {
  const CompleteDelete({
    super.key,
    required this.userSession,
  });

  final UserSession userSession;

  @override
  State<CompleteDelete> createState() => _CompleteDeleteState();
}

class _CompleteDeleteState extends State<CompleteDelete> {
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
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitle: AppLocalizations.of(context)!.customer_details,
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
                20.heightSp,
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
                        label: AppLocalizations.of(context)!.scan_id_card,
                        fontColor: context.scaffoldBackgroundColor,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                54.heightSp,
                CustomElevatedButton(
                  onPressed: next,
                  label: AppLocalizations.of(context)!.next,
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
        await Future.delayed(const Duration(seconds: 1));
      },
      onComplete: (_) {
        context.push(
          widget: CompleteRegistrationP1(
            userSession: widget.userSession,
          ),
        );
      },
      onError: (_) {},
    );
  }
}
