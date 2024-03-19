import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badge;

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
    required this.imageProfile,
    required this.imageCompany,
  });

  final UserSession userSession;
  final XFile? imageProfile;
  final Set<XFile>? imageCompany;

  @override
  State<CompleteRegistrationC2> createState() => _CompleteRegistrationC2State();
}

class _CompleteRegistrationC2State extends State<CompleteRegistrationC2> {
  Set<XFile> imageCompanyTaxt = {};

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
                    await Functions.of(context).pickImage(
                      source: ImageSource.camera,
                      onPick: (xfile) {
                        setState(() {
                          imageCompanyTaxt.add(xfile);
                        });
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 0.25.sh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.textTheme.headlineSmall!.color!,
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
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
                      ],
                    ),
                  ),
                ),
                16.heightSp,
                Wrap(
                  spacing: 10.sp,
                  runSpacing: 10.sp,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: imageCompanyTaxt
                      .map(
                        (image) => badge.Badge(
                          badgeContent: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          badgeStyle: badge.BadgeStyle(
                            badgeColor: Styles.red,
                            elevation: 0,
                            borderSide: BorderSide(
                              color: context.scaffoldBackgroundColor,
                              width: 2.sp,
                            ),
                            // padding: EdgeInsets.all(9.sp),
                          ),
                          badgeAnimation: const badge.BadgeAnimation.scale(
                            toAnimate: false,
                          ),
                          position: badge.BadgePosition.topEnd(
                            top: -2.sp,
                            end: -2.sp,
                          ),
                          showBadge: true,
                          onTap: () {
                            setState(() {
                              imageCompanyTaxt.remove(image);
                            });
                          },
                          child: CircleAvatar(
                            radius: 38.sp,
                            backgroundColor: context.primaryColor,
                            child: CircleAvatar(
                              radius: 34.sp,
                              backgroundColor:
                                  context.textTheme.headlineSmall!.color,
                              backgroundImage: Image.file(image.toFile).image,
                            ),
                          ),
                        ),
                      )
                      .toList(),
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
        await UserServices.of(widget.userSession).post(
          context,
          imageProfile: widget.imageProfile?.toFile,
          imageCompany: widget.imageCompany?.map((e) => e.toFile).toList(),
          imageCompanyTax: imageCompanyTaxt.map((e) => e.toFile).toList(),
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
    );
  }
}
