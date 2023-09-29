import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions.dart';
import '../../../tools.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    required this.onTap,
  });

  final TabController controller;
  final List<String> tabs;
  final void Function(int) onTap;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(
          width: 1.sp,
          color: context.textTheme.headlineMedium!.color!,
        ),
      ),
      child: TabBar(
        controller: widget.controller,
        labelPadding: EdgeInsets.symmetric(vertical: 14.sp),
        labelColor: Colors.white,
        labelStyle: Styles.poppins(
          fontSize: 15.sp,
          fontWeight: Styles.semiBold,
          height: 1.2,
        ),
        unselectedLabelColor: context.textTheme.headlineLarge!.color!,
        unselectedLabelStyle: Styles.poppins(
          fontSize: 15.sp,
          fontWeight: Styles.semiBold,
          height: 1.2,
        ),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: Styles.green,
        ),
        indicatorColor: Styles.green,
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.fill,
        tabs: widget.tabs
            .map(
              (tab) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tab,
                  ),
                ],
              ),
            )
            .toList(),
        onTap: widget.onTap,
      ),
    );
  }
}
