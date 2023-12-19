import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../controller/services.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models_map.dart';
import '../../model_widgets.dart';

/// Place finder by address.
class LocationPickerSearch extends StatefulWidget {
  const LocationPickerSearch({
    super.key,
    required this.onPick,
  });

  /// On pick place, center map in Business Location screen to the picked place coordinates.
  final void Function(Place) onPick;

  @override
  State<LocationPickerSearch> createState() => _LocationPickerSearchState();
}

class _LocationPickerSearchState extends State<LocationPickerSearch> {
  NotifierBool notifierSearching = NotifierBool.init(false);
  TextEditingController controller = TextEditingController();
  List<PlaceAutoComplete>? places;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: ValueListenableBuilder(
          valueListenable: notifierSearching.notifier,
          builder: (context, isSearching, _) {
            return Column(
              children: [
                CustomAppBarBackground(
                  type: AppBarBackgroundType.shrink,
                  appBarTitleWidget: const CustomAppBarLogo(),
                  appBarLeading: AppBarActionButton(
                    icon: context.backButtonIcon,
                    onTap: context.pop,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                  ),
                  child: CustomTextFormField(
                    controller: controller,
                    hintText: AppLocalizations.of(context)!.search,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    prefixIcon: AwesomeIcons.magnifying_glass,
                    suffix: isSearching
                        ? Padding(
                            padding: EdgeInsets.all(12.sp),
                            child: SizedBox(
                              width: 16.sp,
                              height: 16.sp,
                              child: SpinKitRing(
                                color: context.b1,
                                lineWidth: 2.sp,
                                size: 16.sp,
                              ),
                            ),
                          )
                        : null,
                    suffixIcon: !isSearching && controller.text.isNotEmpty
                        ? Icons.close
                        : null,
                    onEditingComplete: () {
                      notifierSearching.setValue(true);
                      GoogleMapsApi.queryAutoComplete(controller.text).then(
                        (result) {
                          places = result;
                          notifierSearching.setValue(false);
                        },
                      ).catchError(
                        (_) {
                          notifierSearching.setValue(false);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: notifierSearching.notifier,
                    builder: (context, isSearching, _) {
                      if (places == null) return const SizedBox.shrink();
                      if (isSearching) {
                        return const Align(
                          alignment: Alignment.topCenter,
                          child: CustomLoadingIndicator(
                            isSliver: false,
                          ),
                        );
                      }
                      if (places!.isEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            200.heightH,
                            Icon(
                              AwesomeIcons.circle_info,
                              color: context.b2,
                              size: 36.sp,
                            ),
                            32.heightSp,
                            Text(
                              AppLocalizations.of(context)!.locations_empty,
                              textAlign: TextAlign.center,
                              style: context.h3b1.regular,
                            ),
                          ],
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.sp,
                          horizontal: 16.sp,
                        ).add(
                          EdgeInsets.only(
                            bottom: context.viewPadding.bottom + 20.sp,
                          ),
                        ),
                        itemBuilder: (contgext, index) => PlaceTile(
                          place: places![index],
                          onPick: widget.onPick,
                        ),
                        separatorBuilder: (context, index) => CustomDivider(
                          height: 6.sp,
                        ),
                        itemCount: places!.length,
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class PlaceTile extends StatelessWidget {
  const PlaceTile({
    super.key,
    required this.place,
    required this.onPick,
  });

  final PlaceAutoComplete place;
  final void Function(Place) onPick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        Dialogs.of(context).runAsyncAction<Place>(
          future: () async {
            return await GoogleMapsApi.getPlaceById(place.placeId);
          },
          onComplete: (place) {
            if (place == null) return;
            onPick(place);
            context.pop();
          },
        );
      },
      leading: Icon(
        AwesomeIcons.map_pin,
        size: 24.sp,
        color: context.b1,
      ),
      title: Text(
        place.structuredFormatting.mainText,
        style: context.h4b1,
      ),
      dense: true,
      minLeadingWidth: 24.sp,
      subtitle: Text(
        place.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.h5b1.regular,
      ),
      trailing: Icon(
        AwesomeIcons.arrow_up_right_from_square,
        size: 20.sp,
        color: context.b1,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.sp),
    );
  }
}
