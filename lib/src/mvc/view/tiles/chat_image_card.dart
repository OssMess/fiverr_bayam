import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class ChatImageCard extends StatelessWidget {
  const ChatImageCard({
    super.key,
    required this.aspectRatio,
    required this.index,
    required this.images,
  });

  final double aspectRatio;
  final int index;
  final List<ImageProvider<Object>> images;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Dialogs.of(context).showMultiImageSlideShow(
        images: images,
        initialPage: index,
      ),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: images[index],
              fit: BoxFit.cover,
            ),
          ),
          child: images.length > 3 && index == 3
              ? ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(100),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 3,
                      sigmaY: 3,
                    ),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.scaffoldBackgroundColor.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '+${images.length - 4}',
                        style: Styles.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textTheme.displayLarge!.color,
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
