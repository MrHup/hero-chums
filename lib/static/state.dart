import 'package:get/get.dart';

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
  static var user;
  static var currentMarker = MarkerState(0, 0).obs;
  static var isMarkerOpen = false.obs;
}
// have a stack
// in top layer, based on a current marker that is being observed
// render the modal layout