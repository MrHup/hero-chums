import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/bitmap_convertor.dart';
import 'package:hero_chum/static/firebase_repo.dart';

class HomeScreenController extends GetxController {
  HomeScreenController();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};

  List<MarkerModel> markerDataList = [];

  void handleTap(LatLng tappedPoint) async {}

  void changeMapMode(GoogleMapController mapController) {
    void setMapStyle(String mapStyle, GoogleMapController mapController) {
      mapController.setMapStyle(mapStyle);
    }

    _getJsonFile("map_styles/style_full_standard.json")
        .then((value) => setMapStyle(value, mapController));
  }

  Future<String> _getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  Future<List<MarkerModel>> getMarkers() async {
    final FirebaseRepository _fbRepo = Get.find();
    markerDataList = await _fbRepo.fetchAllMarkers();
    for (var mark in markerDataList) {
      _addCustomMarker(mark);
    }

    return markerDataList;
  }

  void _addCustomMarker(MarkerModel mark) async {
    final bitmapDescriptor =
        await createBitmapDescriptorFromText(mark.category!);
    final marker = Marker(
        markerId: MarkerId(mark.location.toString()), // Ensure unique ID
        position: LatLng(mark.location!.latitude, mark.location!.longitude),
        icon: bitmapDescriptor);
    markers.add(marker);
  }

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut(() => FirebaseRepository());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
