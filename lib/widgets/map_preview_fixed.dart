import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FixedMapPreview extends StatelessWidget {
  final double radius;
  final LatLng mark;
  final Completer<GoogleMapController> _controller = Completer();

  FixedMapPreview({
    Key? key,
    this.radius = 100,
    required this.mark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: radius * 2, // Diameter
        height: radius * 2, // Diameter
        child: GoogleMap(
          onMapCreated: (controller) => _controller.complete(controller),
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(mark.latitude, mark.longitude),
            zoom: 13.75,
          ),
          mapType: MapType.normal,
          myLocationEnabled: false,
          tiltGesturesEnabled: false,
          markers: {
            Marker(
                markerId: const MarkerId('center'),
                position: LatLng(mark.latitude, mark.longitude))
          },
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
        ),
      ),
    );
  }
}
