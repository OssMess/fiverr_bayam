// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../settings.dart';
import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../model_widgets_screens.dart';
import '../../screens.dart';

class Page5PersonProfile extends StatelessWidget {
  const Page5PersonProfile({
    super.key,
    required this.userSession,
    required this.settingsController,
    required this.pageNotifier,
  });

  final UserSession userSession;
  final SettingsController settingsController;
  final NotifierPage pageNotifier;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        StatefulBuilder(
          builder: (context, setState) {
            return SliverToBoxAdapter(
              child: ProfileHeader(
                displayName: '${userSession.firstName} ${userSession.lastName}',
                email: userSession.email,
                imageProfile: userSession.imageProfile,
                isVerified: userSession.isVerified,
                elapsedOnline: null,
                description: userSession.bio,
                onTapImage: () => Functions.of(context).pickImage(
                  source: ImageSource.gallery,
                  crop: true,
                  onPick: (xfile) {
                    Dialogs.of(context).runAsyncAction(
                      future: () async {
                        await UserServices.of(userSession).post(
                          imageProfile: xfile.toFile,
                        );
                      },
                    );
                  },
                ),
                onTapDescription: () =>
                    Dialogs.of(context).showTextValuePickerDialog(
                  title: AppLocalizations.of(context)!.about,
                  hintText: AppLocalizations.of(context)!.description_hint,
                  initialvalue: userSession.bio,
                  onPick: (value) {
                    if (userSession.bio == value) return;
                    userSession.bio = value;
                    userSession.updateUserSession(context, setState);
                  },
                  validator: Validators.validateNotNull,
                  maxLines: 5,
                  maxLength: 200,
                  textInputType: TextInputType.multiline,
                ),
              ),
            );
          },
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.sp),
                child: ProfileRowActions(
                  actions: [
                    ModelIconButton(
                      icon: AwesomeIcons.facebook_f,
                      color: userSession.facebookUrl.isNullOrEmpty
                          ? context.textTheme.headlineLarge!.color
                          : const Color(0xFF3B5998),
                      onPressed: () =>
                          Dialogs.of(context).showTextValuePickerDialog(
                        title: AppLocalizations.of(context)!.facebook_url,
                        hintText: AppLocalizations.of(context)!.url_hint,
                        initialvalue: userSession.facebookUrl,
                        showPasteButton: true,
                        onPick: (value) async {
                          if (userSession.facebookUrl == value) return;
                          if (await validateUrl(context, value) == null) return;
                          userSession.facebookUrl = value;
                          userSession.updateUserSession(context, setState);
                        },
                        validator: Validators.validateUrlOptional,
                      ),
                    ),
                    ModelIconButton(
                      icon: AwesomeIcons.twitter,
                      color: userSession.twitterUrl.isNullOrEmpty
                          ? context.textTheme.headlineLarge!.color
                          : const Color(0xFF00ACEE),
                      onPressed: () =>
                          Dialogs.of(context).showTextValuePickerDialog(
                        title: AppLocalizations.of(context)!.twitter_url,
                        hintText: AppLocalizations.of(context)!.url_hint,
                        initialvalue: userSession.twitterUrl,
                        showPasteButton: true,
                        onPick: (value) async {
                          if (userSession.twitterUrl == value) return;
                          if (await validateUrl(context, value) == null) return;
                          userSession.twitterUrl = value;
                          userSession.updateUserSession(context, setState);
                        },
                        validator: Validators.validateUrlOptional,
                      ),
                    ),
                    ModelIconButton(
                      icon: AwesomeIcons.linkedin_in,
                      color: userSession.linkedinUrl.isNullOrEmpty
                          ? context.textTheme.headlineLarge!.color
                          : const Color(0xFF0A66C2),
                      onPressed: () =>
                          Dialogs.of(context).showTextValuePickerDialog(
                        title: AppLocalizations.of(context)!.linkedin_url,
                        hintText: AppLocalizations.of(context)!.url_hint,
                        initialvalue: userSession.linkedinUrl,
                        showPasteButton: true,
                        onPick: (value) async {
                          if (userSession.linkedinUrl == value) return;
                          if (await validateUrl(context, value) == null) return;
                          userSession.linkedinUrl = value;
                          userSession.updateUserSession(context, setState);
                        },
                        validator: Validators.validateUrlOptional,
                      ),
                    ),
                    ModelIconButton(
                      icon: AwesomeIcons.share_from_square,
                      color: Styles.green,
                      onPressed: () => Share.share(
                        'Share example, what to write here will be changed later',
                        subject: 'Title share',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.ads,
            title: AppLocalizations.of(context)!.manage_ads,
            onTap: () => pageNotifier.setCurrentPage(2),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        16.sliverSp,
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.gear,
            title: AppLocalizations.of(context)!.settings,
            onTap: () => context.push(
              widget: SettingsScreen(
                userSession: userSession,
                settingsController: settingsController,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        16.sliverSp,
        SliverToBoxAdapter(
          child: CustomElevatedListTile(
            leadingIcon: AwesomeIcons.door_exit,
            title: AppLocalizations.of(context)!.logout,
            onTap: () => Dialogs.of(context).showCustomDialog(
              title: AppLocalizations.of(context)!.logout,
              subtitle: AppLocalizations.of(context)!.logout_subtitle,
              yesAct: ModelTextButton(
                label: AppLocalizations.of(context)!.continu,
                color: Styles.red,
                onPressed: () {
                  userSession.onSignout();
                  context.popUntilFirst();
                },
              ),
              noAct: ModelTextButton(
                label: AppLocalizations.of(context)!.cancel,
                fontColor: context.textTheme.displayLarge!.color,
                color: Styles.red[50],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24.sp),
          ),
        ),
        (context.viewPadding.bottom + 20.sp).sliver,
      ],
    );
  }

  Future<String?> validateUrl(BuildContext context, String? value) async {
    try {
      if (!await canLaunchUrl(Uri.parse(value ?? ''))) {
        throw Exception();
      }
      return value;
    } catch (e) {
      if (!context.mounted) return null;
      context.showSnackBar(
        message: AppLocalizations.of(context)!.invalid_url,
      );
      return null;
    }
  }
}
