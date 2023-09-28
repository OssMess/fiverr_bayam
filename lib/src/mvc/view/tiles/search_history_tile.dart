import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models_ui.dart';

class SearchHistoryTile extends StatelessWidget {
  const SearchHistoryTile({
    super.key,
    required this.searchHistory,
    required this.onTap,
    required this.onClose,
  });

  final SearchHistory searchHistory;
  final void Function() onTap;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  searchHistory.category.title,
                  style: Styles.poppins(
                    fontSize: 15.sp,
                    fontWeight: Styles.semiBold,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
                Text(
                  searchHistory.category.subtitle,
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.medium,
                    color: context.textTheme.displayMedium!.color,
                  ),
                ),
              ],
            ),
          ),
          4.widthSp,
          SizedBox(
            width: 70.sp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 18.sp,
                  backgroundColor: context.textTheme.headlineSmall!.color,
                  backgroundImage: CachedNetworkImageProvider(
                    searchHistory.companyPhotoUrl,
                  ),
                ),
                4.heightSp,
                Text(
                  searchHistory.companyName,
                  overflow: TextOverflow.fade,
                  style: Styles.poppins(
                    fontSize: 12.sp,
                    fontWeight: Styles.medium,
                    color: context.textTheme.displayLarge!.color,
                  ),
                ),
              ],
            ),
          ),
          4.widthSp,
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.close,
              size: 24.sp,
              color: context.textTheme.displayLarge!.color,
            ),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}
