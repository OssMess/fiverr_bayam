import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../extensions.dart';
import '../../../../tools.dart';
import '../../../model/change_notifiers.dart';
import '../../../model/enums.dart';
import '../../../model/models.dart';
import '../../model_widgets.dart';
import '../../screens.dart';

/// Business location setup.
class PromoteLocation extends StatefulWidget {
  const PromoteLocation({
    super.key,
    required this.userSession,
    required this.ad,
    required this.plan,
  });

  final UserSession userSession;
  final Ad ad;
  final Plan plan;

  @override
  State<PromoteLocation> createState() => PromoteLocationState();
}

class PromoteLocationState extends State<PromoteLocation> {
  NotifierString locationNotifier = NotifierString.init('--');
  LatLng? location;
  NotifierBool isSearchingNotifier = NotifierBool.init(false);

  /// A notifier to indicate whether the location is can be used or not.
  /// It is used to show or hide the location floating action button.
  NotifierBool locationEnabledNotifier = NotifierBool.init(false);

  /// Map controller
  GoogleMapController? googleMapController;

  /// user current location
  LatLng? currentLocation;

  /// initial camera position on the map. Set to Danemark's capital.
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(3.856911, 11.520441),
    zoom: 10,
  );

  /// Current camera position on the map, updates as user moves the map.
  CameraPosition? cameraPosition;

  /// nearby zoom value.
  final double zoomNearby = 13;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // location = widget.initialLocation;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
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
          Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
            ).copyWith(bottom: 16.sp),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return CustomTextFormField(
                  controller: controller,
                  hintText: AppLocalizations.of(context)!.search,
                  prefixIcon: AwesomeIcons.magnifying_glass,
                  readOnly: true,
                  suffixIcon: controller.text.isNotEmpty ? Icons.close : null,
                  suffixOnTap: controller.text.isNotEmpty
                      ? () => controller.text = ''
                      : null,
                  onTap: () => context.push(
                    widget: PromoteLocationSearch(onPick: (place) {
                      animateCamera(place.latlng);
                      controller.text = place.formattedAddress;
                    }),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  trafficEnabled: false,
                  buildingsEnabled: false,
                  indoorViewEnabled: false,
                  liteModeEnabled: false,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: true,
                  tiltGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  initialCameraPosition: initialCameraPosition,
                  onMapCreated: (controller) async {
                    googleMapController = controller;
                    // googleMapController!.setMapStyle(mapStyle);
                    if (location != null) {
                      await animteCameraToLocation();
                    } else {
                      await initCurrentLocation();
                    }
                  },
                  onCameraMove: (position) {
                    locationNotifier.setValue(latlngToCoords(position.target));
                    location = position.target;
                  },
                ),
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.sp),
                      child: SvgPicture.asset(
                        'assets/icons/location_selected.svg',
                        width: 40.sp,
                        height: 40.sp,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 16.sp,
            ).add(
              EdgeInsets.only(
                bottom: context.viewPadding.bottom,
              ),
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.pin_location,
                  style: context.h2b1,
                ),
                16.heightSp,
                ValueListenableBuilder(
                  valueListenable: locationNotifier.notifier,
                  builder: (context, location, _) {
                    return Text(
                      location,
                      style: context.h4b1,
                    );
                  },
                ),
                16.heightSp,
                CustomElevatedButton(
                  label: AppLocalizations.of(context)!.continu,
                  onPressed: () {
                    if (location == null) return;
                    context.push(
                      widget: PromoteAd(
                        userSession: widget.userSession,
                        ad: widget.ad,
                        plan: widget.plan,
                        location: location!,
                      ),
                    );
                    // widget.onPick(location!);
                    // context.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String latlngToCoords(LatLng latlng) {
    String lat = NumberFormat('0.######').format(latlng.latitude);
    String lng = NumberFormat('0.######').format(latlng.longitude);
    return '$lat,$lng';
  }

  /// Get map style based on device theme.
  String get mapStyle {
    // if (MediaQuery.of(context).platformBrightness == Brightness.light) {
    return '[{"featureType": "poi.attraction","stylers": [{"visibility": "off"}]},{"featureType": "poi.business","stylers": [{"visibility": "off"}]},{"featureType": "poi.government","stylers": [{"visibility": "off"}]},{"featureType": "poi.medical","stylers": [{"visibility": "off"}]},{"featureType": "poi.place_of_worship","stylers": [{"visibility": "off"}]},{"featureType": "poi.school","stylers": [{"visibility": "off"}]},{"featureType": "poi.sports_complex","stylers": [{"visibility": "off"}]},{"featureType": "transit","stylers": [{"visibility": "off"}]}]';
    // } else {
    // return '[{"elementType": "geometry","stylers": [{"color": "#242f3e"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#746855"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#242f3e"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.attraction","stylers": [{"visibility": "off"}]},{"featureType": "poi.business","stylers": [{"visibility": "off"}]},{"featureType": "poi.government","stylers": [{"visibility": "off"}]},{"featureType": "poi.medical","stylers": [{"visibility": "off"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "poi.place_of_worship","stylers": [{"visibility": "off"}]},{"featureType": "poi.school","stylers": [{"visibility": "off"}]},{"featureType": "poi.sports_complex","stylers": [{"visibility": "off"}]},{"featureType": "road","elementType": "geometry","stylers": [{"color": "#38414e"}]},{"featureType": "road","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.highway","elementType": "geometry","stylers": [{"color": "#746855"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "transit","stylers": [{"visibility": "off"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"color": "#17263c"}]}]';
    // }
  }

  Future<void> initCurrentLocation() async {
    if (googleMapController == null) return;
    if (await Permissions.of(context).showLocationEnabled()) {
      locationEnabledNotifier.setValue(false);
      return;
    }
    // ignore: use_build_context_synchronously
    if (await Permissions.of(context).showLocationPermission()) {
      locationEnabledNotifier.setValue(false);

      return;
    }
    locationEnabledNotifier.setValue(true);
    Position location = await Geolocator.getCurrentPosition();
    currentLocation = LatLng(location.latitude, location.longitude);
    await animateCamera(currentLocation!);
  }

  Future<void> animteCameraToLocation() async {
    await animateCamera(location!);
  }

  Future<void> animateCamera(LatLng position) async {
    await googleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position,
          zoom: zoomNearby,
        ),
      ),
    );
  }
}
