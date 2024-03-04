import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badge;

import '../../../extensions.dart';
import '../../../tools.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.index,
    this.image,
    this.onAddImages,
    this.onDeleteImage,
  }) : assert((image == null && onDeleteImage == null && onAddImages != null) ||
            (image != null && onDeleteImage != null && onAddImages == null));

  final int index;
  final ImageProvider<Object>? image;
  final void Function(Iterable<XFile>)? onAddImages;
  final void Function(int)? onDeleteImage;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return InkResponse(
        onTap: () async {
          if (await Permissions.of(context).showPhotoLibraryPermission()) {
            return;
          }
          ImagePicker()
              .pickMultiImage(
            imageQuality: 80,
            maxHeight: 720,
            maxWidth: 720,
          )
              .then(
            (files) {
              onAddImages!(files);
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
      onTap: () => onDeleteImage!(index),
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
                image: image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
