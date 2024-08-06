import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/claim_screen_controller.dart';
import 'package:hero_chum/controllers/create_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/bitmap_convertor.dart';
import 'package:hero_chum/static/firebase_repo.dart';
import 'package:hero_chum/static/state.dart';

class HomeScreenController extends GetxController {
  HomeScreenController();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  var markers = <Marker>{}.obs;

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
    await Future.delayed(const Duration(seconds: 2));
    Get.put(FirebaseRepository());
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

    void onTap() {
      Get.put(ClaimScreenController());
      Get.toNamed("/claim", arguments: mark);
    }

    final markerUID = mark.location!.latitude.toString() +
        mark.location!.longitude.toString();

    print('Creating marker for category: ${mark.category} with UID $markerUID');
    GlobalState.currentLocation =
        LatLng(mark.location!.latitude, mark.location!.longitude);

    final marker = Marker(
        markerId: MarkerId(markerUID),
        position: GlobalState.currentLocation,
        onTap: onTap,
        icon: bitmapDescriptor);
    markers.add(marker);
  }

  void goToCreateScreen() {
    LatLng tappedPoint = LatLng(GlobalState.currentLocation.latitude,
        GlobalState.currentLocation.longitude);

    Get.put(CreateScreenController());
    Get.toNamed("/create", arguments: tappedPoint);
  }

  void mapTapped(LatLng tappedPoint) async {
    // final GoogleMapController controller = await mapController.future;
    // controller.animateCamera(
    //   CameraUpdate.newLatLng(tappedPoint),
    // );

    if (!GlobalState.isMarkerOpen.value) {
      _addCurrentMarker(tappedPoint);
      zoomIn(tappedPoint, 20);
    } else {
      clean();
      zoomIn(tappedPoint, 13.75);
    }
  }

  void zoomIn(LatLng tappedPoint, double zoom) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
      LatLng(tappedPoint.latitude, tappedPoint.longitude),
      zoom,
    ));
  }

  void _addCurrentMarker(LatLng location) async {
    final marker = Marker(
      markerId: const MarkerId("InProgress"),
      position: location,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(44, 67)),
          'assets/images/custom_mark.png'),
    );
    GlobalState.isMarkerOpen.value = true;
    GlobalState.currentLocation = location;

    // remove all markers with same id
    markers.removeWhere((element) => element.markerId.value == "InProgress");
    markers.add(marker);
  }

  void clean() {
    print("Cleaning");
    // remove InProgress markers
    markers.removeWhere((element) => element.markerId.value == "InProgress");
    GlobalState.isMapBlocked.value = false;
    GlobalState.isMarkerOpen.value = false;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    clean();
  }

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut(() => FirebaseRepository());
    Get.lazyPut(() => ClaimScreenController());
    Get.lazyPut(() => CreateScreenController());
    clean();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
