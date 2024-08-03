import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerState {
  double longitude;
  double latitude;
  String imageUrl = "";
  String title = "";

  MarkerState(this.longitude, this.latitude,
      {this.imageUrl = "", this.title = ""});
}

class GlobalState {
  static var isUserLoggedIn = false.obs;
  static User? user;
  static var currentMarker = MarkerState(0, 0).obs;
  static var isMarkerOpen = false.obs;
  static var isMapBlocked = false.obs;
  static var gems = 100.obs;
  static LatLng currentLocation = const LatLng(0, 0);
}
// have a stack
// in top layer, based on a current marker that is being observed
// render the modal layout