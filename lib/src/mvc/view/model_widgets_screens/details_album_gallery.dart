import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/enums.dart';

class DetailsAlbumGallery extends StatelessWidget {
  const DetailsAlbumGallery({
    super.key,
    required this.photosUrl,
    required this.description,
    this.adType,
    required this.pageController,
  });

  final List<String> photosUrl;
  final String description;
  final AdType? adType;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14.sp),
          child: SizedBox(
            width: double.infinity,
            height: 0.3.sh,
            child: PageView.builder(
              controller: pageController,
              itemCount: photosUrl.length,
              itemBuilder: (context, index) => CachedNetworkImage(
                imageUrl: photosUrl.elementAt(index),
                fit: BoxFit.cover,
                color: context.textTheme.headlineSmall!.color,
                progressIndicatorBuilder: (context, url, progress) => Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: Styles.green,
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: context.textTheme.headlineSmall!.color,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    adType != null
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.sp,
                              vertical: 6.sp,
                            ),
                            decoration: BoxDecoration(
                              color: adType!.toBackgroundColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              adType!.translate(context),
                              style: Styles.poppins(
                                fontSize: 14.sp,
                                fontWeight: Styles.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    CircleAvatar(
                      backgroundColor: context.textTheme.headlineSmall!.color,
                      backgroundImage: const CachedNetworkImageProvider(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Flag_of_Cameroon.png/640px-Flag_of_Cameroon.png',
                      ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: Styles.poppins(
                    fontSize: 16.sp,
                    fontWeight: Styles.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
