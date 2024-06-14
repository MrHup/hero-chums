import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/create_mark_popup.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController c) {
              changeMapMode(c);
              _controller.complete(c);
            },
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            trafficEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(45.756685, 21.229283),
              zoom: 13.75,
            ),
            markers: _markers,
            zoomControlsEnabled: false,
            // zoomGesturesEnabled: false,
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                northeast: const LatLng(45.812293, 21.348564),
                southwest: const LatLng(45.693001, 21.150284),
              ),
            ),

            onTap: _handleTap,
          ),
          CreateMarkPopup(),
        ],
      ),
    );
  }

  // Handles the tap on the map
  void _handleTap(LatLng tappedPoint) async {
    // _addCustomMarker(tappedPoint);
    if (!GlobalState.isMarkerOpen.value) {
      _addCurrentMarker(tappedPoint);
      GlobalState.currentMarker.value =
          MarkerState(tappedPoint.latitude, tappedPoint.longitude);
      GlobalState.isMarkerOpen.value = true;

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(tappedPoint),
      );
    } else {
      GlobalState.isMarkerOpen.value = false;
      // remove custom marker with id "InProgress" from marker list
      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == "InProgress");
      });
    }
  }

  void _addCurrentMarker(LatLng location) async {
    final marker = Marker(
      markerId: const MarkerId("InProgress"),
      position: location,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(44, 67)),
          'assets/images/custom_mark.png'),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  // Add a custom marker at the tapped location
  void _addCustomMarker(LatLng location) async {
    final marker = Marker(
      markerId: MarkerId(location.toString()), // Ensure unique ID
      position: location,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(48, 68)),
          'assets/images/leaf_mark.png'),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile("map_styles/style_full_standard.json")
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }
}
