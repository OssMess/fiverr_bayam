import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badge;

import '../../../../extensions.dart';
import '../../../controller/services.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../../model/models_ui.dart';
import '../../model_widgets.dart';
import '../../../../tools.dart';

class CreateAd extends StatefulWidget {
  const CreateAd({
    super.key,
    required this.userSession,
    required this.ad,
  });

  final UserSession userSession;
  final Ad? ad;

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _keyForm = GlobalKey();
  int adTypeIndex = 0;
  String? title, description, location;
  Category? category;
  Set<String> stringTags = {};
  Set<String> images = {};
  late TabController tabController;
  TextEditingController categoryConttroller = TextEditingController();
  TextEditingController tagsConttroller = TextEditingController();

  @override
  void initState() {
    if (widget.ad != null) {
      adTypeIndex = widget.ad?.adType.index ?? -1;
      title = widget.ad!.title;
      description = widget.ad!.description;
      category = widget.ad!.category;
      location = widget.ad!.location;
      stringTags.addAll(widget.ad!.tags);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        categoryConttroller.text = category?.translateTitle(context) ?? '';
      });
    }
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    categoryConttroller.dispose();
    tagsConttroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarBackground(
            type: AppBarBackgroundType.shrink,
            appBarTitleWidget: const CustomAppBarLogo(),
            appBarLeading: AppBarActionButton(
              icon: context.backButtonIcon,
              onTap: context.pop,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Form(
                  key: _keyForm,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.ad_title,
                        hintText: AppLocalizations.of(context)!.ad_title_hint,
                        initialValue: title,
                        onSaved: (value) {
                          title = value;
                        },
                        validator: Validators.validateNotNull,
                        keyboardType: TextInputType.name,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: categoryConttroller,
                        labelText: AppLocalizations.of(context)!.category,
                        hintText: AppLocalizations.of(context)!.category_hint,
                        suffixIcon: Icons.arrow_drop_down,
                        validator: Validators.validateNotNull,
                        keyboardType: TextInputType.name,
                        onTap: () =>
                            Dialogs.of(context).showSingleValuePickerDialog(
                          title: AppLocalizations.of(context)!.category_hint,
                          values: Category.values
                              .map(
                                (e) => e.translateTitle(context),
                              )
                              .toList(),
                          initialvalue: category?.translateTitle(context),
                          onPick: (value) {
                            categoryConttroller.text = value;
                            category = {
                              0: Category.agriculture,
                              1: Category.livestock,
                              2: Category.fishing,
                              3: Category.phytosnitary,
                              4: Category.localFoodProducts,
                              5: Category.rentalStorageFacilities,
                            }[Category.values
                                .map(
                                  (e) => e.translateTitle(context),
                                )
                                .toList()
                                .indexOf(value)]!;
                          },
                        ),
                      ),
                      16.heightSp,
                      CustomTabBar(
                        controller: tabController,
                        tabs: [
                          AppLocalizations.of(context)!.buy,
                          AppLocalizations.of(context)!.sell,
                          AppLocalizations.of(context)!.rent,
                        ],
                        onTap: (tab) {
                          adTypeIndex = tab;
                        },
                      ),
                      16.heightSp,
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.sp),
                        decoration: BoxDecoration(
                          color: context.textTheme.headlineSmall!.color,
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.add_images,
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                color: context.textTheme.displayLarge!.color,
                                fontWeight: Styles.semiBold,
                                height: 1.2,
                              ),
                            ),
                            CustomDivider(
                              height: 17.sp,
                              padding: EdgeInsets.symmetric(horizontal: 32.sp),
                            ),
                            SizedBox(
                              height: 100.sp,
                              child: ListView.separated(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.sp),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => ImageCard(
                                  index: index,
                                  images: images,
                                  onAddImages: (elements) => setState(() {
                                    images.addAll(elements);
                                  }),
                                  onDeleteImage: (value) => setState(() {
                                    images.remove(value);
                                  }),
                                ),
                                separatorBuilder: (context, index) => 8.widthSp,
                                itemCount: images.length + 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.description,
                        hintText:
                            AppLocalizations.of(context)!.description_hint,
                        initialValue: description,
                        maxLines: 8,
                        onSaved: (value) {
                          description = value;
                        },
                        validator: Validators.validateNotNull,
                        keyboardType: TextInputType.multiline,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        labelText: AppLocalizations.of(context)!.location,
                        hintText: AppLocalizations.of(context)!.location_hint,
                        initialValue: location,
                        onSaved: (value) {
                          location = value;
                        },
                        validator: Validators.validateNotNull,
                        keyboardType: TextInputType.name,
                      ),
                      16.heightSp,
                      CustomTextFormFieldBounded(
                        controller: tagsConttroller,
                        labelText: AppLocalizations.of(context)!.tags,
                        hintText: AppLocalizations.of(context)!.tags_hint,
                        keyboardType: TextInputType.name,
                        suffix: CustomFlatButton(
                          onTap: onAddTag,
                          color: Styles.green[100],
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: Styles.poppins(
                              fontSize: 12.sp,
                              color: Styles.green,
                              fontWeight: Styles.medium,
                            ),
                          ),
                        ),
                        onEditingComplete: onAddTag,
                      ),
                      16.heightSp,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              runSpacing: 8.sp,
                              spacing: 8.sp,
                              children: stringTags
                                  .map(
                                    (text) => CustomFlatButton(
                                      onTap: () {
                                        setState(() {
                                          stringTags.remove(text);
                                        });
                                      },
                                      color: Styles.green[50],
                                      child: Text(
                                        text,
                                        style: Styles.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: Styles.medium,
                                          color: Styles.green,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      24.heightSp,
                      CustomElevatedButton(
                        label: AppLocalizations.of(context)!.submit,
                        onPressed: next,
                      ),
                      (context.viewPadding.bottom + 20.sp).height,
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

  void onAddTag() {
    if (tagsConttroller.text.isNotEmpty &&
        stringTags.add(tagsConttroller.text.capitalizeFirstLetter)) {
      tagsConttroller.text = '';
      setState(() {});
    }
  }

  Future<void> next() async {
    if (!_keyForm.currentState!.validate()) return;
    _keyForm.currentState!.save();
    if (stringTags.isEmpty) {
      Dialogs.of(context).showSnackBar(
        message: AppLocalizations.of(context)!.add_tag_error,
      );
      return;
    }
    Dialogs.of(context).runAsyncAction(
      future: () async {
        List<Tag> tags = [];
        for (var stringTag in stringTags) {
          late Tag tag;
          try {
            tag = await TagServices.get(stringTag);
          } catch (e) {
            tag = await TagServices.post(stringTag);
          } finally {
            tags.add(tag);
          }
        }
        await AdServices.post(
          uid: widget.userSession.uid!,
          title: title!,
          description: description!,
          location: location!,
          adType: adTypeIndex.toAdType,
          category: category!,
          tags: tags,
        );
      },
      onComplete: (_) {
        Dialogs.of(context).showCustomDialog(
          header: AppLocalizations.of(context)!.ad_thankyou_header,
          title: AppLocalizations.of(context)!.success,
          subtitle: AppLocalizations.of(context)!.ad_create_sucess_subtitle,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.continu,
            color: Styles.green,
            onPressed: context.pop,
          ),
        );
      },
      onError: (_) {
        Dialogs.of(context).showCustomDialog(
          header: AppLocalizations.of(context)!.ad_thankyou_header,
          headerColor: Styles.red[600],
          title: AppLocalizations.of(context)!.failed,
          subtitle: AppLocalizations.of(context)!.ad_create_failed_subtitle,
          yesAct: ModelTextButton(
            label: AppLocalizations.of(context)!.try_again,
            color: Styles.green,
            onPressed: next,
          ),
        );
      },
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.index,
    required this.images,
    required this.onAddImages,
    required this.onDeleteImage,
  });

  final int index;
  final Set<String> images;
  final void Function(Iterable<String>) onAddImages;
  final void Function(String) onDeleteImage;

  @override
  Widget build(BuildContext context) {
    if (index == images.length) {
      return InkResponse(
        onTap: () async {
          if (await Permissions.of(context).showPhotoLibraryPermission()) {
            return;
          }
          ImagePicker()
              .pickMultiImage(
            imageQuality: 80,
            maxHeight: 1080,
            maxWidth: 1080,
          )
              .then(
            (files) {
              onAddImages(files.map((e) => e.path));
            },
          );
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.sp),
              color: context.textTheme.headlineLarge!.color,
            ),
            child: Icon(
              AwesomeIcons.image_gallery,
              size: 24.sp,
              color: context.scaffoldBackgroundColor,
            ),
          ),
        ),
      );
    }
    return InkResponse(
      onTap: () => onDeleteImage(
        images.elementAt(index),
      ),
      child: badge.Badge(
        badgeStyle: badge.BadgeStyle(
          badgeColor: context.scaffoldBackgroundColor,
          elevation: 0,
          borderSide: BorderSide.none,
          padding: EdgeInsets.all(5.sp),
        ),
        badgeAnimation: const badge.BadgeAnimation.scale(
          toAnimate: false,
        ),
        position: badge.BadgePosition.topEnd(
          top: 8.sp,
          end: 8.sp,
        ),
        badgeContent: Icon(
          Icons.close,
          color: context.textTheme.displayLarge!.color,
          size: 14.sp,
        ),
        showBadge: true,
        child: AspectRatio(
          aspectRatio: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.sp),
              color: context.textTheme.headlineLarge!.color,
              image: DecorationImage(
                image: Image.file(
                  File(images.elementAt(index)),
                ).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
