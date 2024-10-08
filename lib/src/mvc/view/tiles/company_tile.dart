import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../model_widgets.dart';
import '../screens.dart';
import '../tiles_models.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    super.key,
    required this.userSession,
    required this.userMin,
    this.isExpanded = false,
  });

  final UserSession userSession;
  final UserMin userMin;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userMin,
      child: Consumer<UserMin>(
        builder: (context, userMin, _) {
          return CustomElevatedContainer(
            onTap: () => context.push(
              widget: DetailsCompany(
                userSession: userSession,
                userMin: userMin,
              ),
            ),
            width: isExpanded ? double.infinity : 160.sp,
            height: isExpanded ? 240.sp : null,
            borderRadius: BorderRadius.circular(10.sp),
            child: Column(
              children: [
                Expanded(
                  child: userMin.imageProfileUrl.isNotNullOrEmpty
                      ? CachedNetworkImage(
                          imageUrl: userMin.imageProfileUrl!,
                          fit: BoxFit.cover,
                          color: context.textTheme.headlineSmall!.color,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: Styles.green,
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            margin: isExpanded
                                ? EdgeInsets.all(10.sp)
                                : EdgeInsets.zero,
                            padding: EdgeInsets.all(8.sp),
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                              color: context.textTheme.headlineSmall!.color,
                              borderRadius: BorderRadius.circular(10.sp),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: userMin.preferenceList!.isNotEmpty
                                ? Text(
                                    userMin.preferenceList!.first,
                                    style: Styles.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: Styles.semiBold,
                                      color: Colors.white,
                                      height: 1.2,
                                    ),
                                  )
                                : null,
                          ),
                        )
                      : Container(color: context.b6),
                ),
                Padding(
                  padding: isExpanded
                      ? EdgeInsets.only(bottom: 10.sp).copyWith(top: 8.sp)
                      : EdgeInsets.symmetric(vertical: 8.sp),
                  child: CompanyHeaderTile(
                    logoUrl: userMin.imageProfileUrl,
                    name: userMin.displayName,
                    countryCode: null,
                    isVerified: userMin.isVerified,
                    sizeOffset: 0,
                    padding: EdgeInsetsDirectional.only(start: 10.sp),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
