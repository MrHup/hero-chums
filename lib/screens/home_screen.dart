import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/home_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:rive/rive.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<List<MarkerModel>> _firebaseMarkers = controller.getMarkers();

    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
      body: FutureBuilder<List<MarkerModel>>(
        future: _firebaseMarkers,
        builder:
            (BuildContext context, AsyncSnapshot<List<MarkerModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: RiveAnimation.asset(
                      'assets/animations/herochums.riv',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Loading...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
          return Obx(
            () => GoogleMap(
              onMapCreated: (GoogleMapController c) {
                GlobalState.isMapBlocked.value = false;
                GlobalState.isMarkerOpen.value = false;
                controller.changeMapMode(c);

                controller.mapController.complete(c);
              },
              mapToolbarEnabled: false,
              mapType: MapType.normal,
              trafficEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(45.756685, 21.229283),
                zoom: 13.75,
              ),
              markers: controller.markers,
              zoomControlsEnabled: false,
              cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                  northeast: const LatLng(45.858044, 21.389185),
                  southwest: const LatLng(45.695732, 21.159476),
                ),
              ),
              myLocationButtonEnabled: false,
              webGestureHandling: GlobalState.isMapBlocked.value
                  ? WebGestureHandling.none
                  : WebGestureHandling.auto,
              onTap: controller.handleTap,
            ),
          );
        },
      ),
      drawer: const LeftDrawer(),
    );
  }
}
