import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/models/marker.dart';

class FixedMapPreview extends StatelessWidget {
  final double radius;
  final MarkerModel mark;
  final Completer<GoogleMapController> _controller = Completer();

  FixedMapPreview({
    Key? key,
    this.radius = 100,
    required this.mark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(mark.location!.longitude);

    print("Building clip");
    return ClipOval(
      child: SizedBox(
        width: radius * 2, // Diameter
        height: radius * 2, // Diameter
        child: GoogleMap(
          onMapCreated: (controller) => _controller.complete(controller),
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(mark.location!.latitude, mark.location!.longitude),
            zoom: 13.75,
          ),
          mapType: MapType.normal,
          myLocationEnabled: false,
          tiltGesturesEnabled: false,
          markers: {
            Marker(
                markerId: const MarkerId('center'),
                position:
                    LatLng(mark.location!.latitude, mark.location!.longitude))
          },
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
        ),
      ),
    );
  }
}
