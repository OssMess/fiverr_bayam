import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions.dart';
import '../../model/change_notifiers.dart';
import '../model_widgets.dart';
import '../../../tools.dart';

class MainSearchTextFormField extends StatefulWidget {
  const MainSearchTextFormField({
    super.key,
    required this.notifierViewMode,
  });

  final NotifierPersonViewMode notifierViewMode;

  @override
  State<MainSearchTextFormField> createState() =>
      _MainSearchTextFormFieldState();
}

class _MainSearchTextFormFieldState extends State<MainSearchTextFormField> {
  TextEditingController controller = TextEditingController();
  String? filter;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: CustomTextFormField(
        height: 55.sp,
        controller: controller,
        hintText: AppLocalizations.of(context)!.what_are_you_looking_for,
        prefixIcon: widget.notifierViewMode.isInPageNormal
            ? AwesomeIcons.magnifying_glass
            : context.backButtonIcon,
        fillColor: Styles.green[50],
        onEditingComplete: () {
          widget.notifierViewMode.openPageResults();
          FocusScope.of(context).unfocus();
        },
        textInputAction: TextInputAction.done,
        onTap: () {
          widget.notifierViewMode.openPageSuggestions();
          return;
        },
        prefixOnTap: () {
          if (widget.notifierViewMode.isInPageNormal) return;
          if (widget.notifierViewMode.isInPageSuggestions ||
              widget.notifierViewMode.isInPageResults) {
            widget.notifierViewMode.reset();
            controller.text = '';
            FocusScope.of(context).unfocus();
            return;
          }
        },
        // readOnly: widget.notifierViewMode.isInPageNormal,
        suffix: PopupMenuButton(
          // padding: EdgeInsets.all(20),
          color: Styles.green[50],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4.sp),
            ),
          ),
          onSelected: (value) {
            setState(() {
              filter = value;
            });
          },
          itemBuilder: (context) => [
            AppLocalizations.of(context)!.country,
            AppLocalizations.of(context)!.region,
            AppLocalizations.of(context)!.type_of_ads,
          ]
              .map(
                (element) => PopupMenuItem<String>(
                  height: 34.sp,
                  value: element,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 6.sp,
                  ),
                  child: Text(
                    element,
                    style: Styles.poppins(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              4.widthSp,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: VerticalDivider(
                  color: context.textTheme.headlineMedium!.color,
                  thickness: 1.sp,
                ),
              ),
              8.widthSp,
              Text(
                filter ?? AppLocalizations.of(context)!.country,
                style: Styles.poppins(
                  fontSize: 13.sp,
                  fontWeight: Styles.medium,
                  color: context.textTheme.displayLarge!.color,
                  height: 1.2,
                ),
              ),
              8.widthSp,
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20.sp,
                color: context.textTheme.displayLarge!.color,
              ),
              8.widthSp,
            ],
          ),
        ),
      ),
      //   child: InkResponse(
      //     onTap: () {},
      //     child: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         4.widthSp,
      //         Padding(
      //           padding: EdgeInsets.symmetric(vertical: 8.sp),
      //           child: VerticalDivider(
      //             color: context.textTheme.headlineMedium!.color,
      //             thickness: 1.sp,
      //           ),
      //         ),
      //         8.widthSp,
      //         Text(
      //           AppLocalizations.of(context)!.country,
      //           style: Styles.poppins(
      //             fontSize: 13.sp,
      //             fontWeight: Styles.medium,
      //             color: context.textTheme.displayLarge!.color,
      //             height: 1.2,
      //           ),
      //         ),
      //         8.widthSp,
      //         Icon(
      //           Icons.keyboard_arrow_down_rounded,
      //           size: 20.sp,
      //           color: context.textTheme.displayLarge!.color,
      //         ),
      //         8.widthSp,
      //       ],
      //     ),
      //   ),
      // ),
      // ),
    );
  }
}
