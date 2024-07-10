import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/static/state.dart';

class CircularMapPreview extends StatelessWidget {
  final double radius;
  final Completer<GoogleMapController> _controller = Completer();

  CircularMapPreview({
    Key? key,
    this.radius = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building clip");
    return ClipOval(
      child: SizedBox(
        width: radius * 2, // Diameter
        height: radius * 2, // Diameter
        child: Obx(() => GoogleMap(
              onMapCreated: (controller) => _controller.complete(controller),
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(GlobalState.currentMarker.value.longitude,
                    GlobalState.currentMarker.value.latitude),
                zoom: 13.75,
              ),
              mapType: MapType.normal,
              myLocationEnabled: false,
              tiltGesturesEnabled: false,
              markers: {
                Marker(
                    markerId: MarkerId('center'),
                    position: LatLng(GlobalState.currentMarker.value.longitude,
                        GlobalState.currentMarker.value.latitude))
              },
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              rotateGesturesEnabled: false,
            )),
      ),
    );
  }
}
