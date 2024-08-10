import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/home_screen_controller.dart';
import 'package:hero_chum/models/gemini_response.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/firebase_repo.dart';
import 'package:hero_chum/static/gemini.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/static/utils.dart';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:loader_overlay/loader_overlay.dart';

class CreateScreenController extends GetxController {
  PlatformFile? _selectedFile;
  MarkerModel? marker;
  RxString imageUrl = "".obs;
  TextEditingController textController = TextEditingController();

  void uploadImage() async {
    var picked = await FilePicker.platform.pickFiles(type: FileType.image);

    if (picked != null) {
      _selectedFile = picked.files.first;
      final bytes = _selectedFile!.bytes;
      if (bytes != null) {
        final blob = html.Blob([Uint8List.fromList(bytes)]);
        imageUrl.value = html.Url.createObjectUrlFromBlob(blob);
      }
    }
  }

  Future<void> submit(LatLng location, BuildContext context) async {
    if (_selectedFile == null) {
      Get.snackbar(
        "Error",
        "Please select an image",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        isDismissible: true,
      );
      return;
    }

    if (GlobalState.isUserLoggedIn.value == false) {
      Get.snackbar(
        "Account Required",
        "Create an account in order to make a submission",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        isDismissible: true,
        backgroundColor: Colors.amber,
      );
      Get.toNamed("/register");
      return;
    }

    context.loaderOverlay.show();

    GeminiResponseModel geminiResponse =
        await geminiCall(_selectedFile!, textController.text);
    print("Obtained response $geminiResponse");

    if (geminiResponse.title == "error") {
      Get.snackbar(
        "Warning",
        "Your submission was flagged by our AI as not appropriate. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        isDismissible: true,
        backgroundColor: Colors.amber,
      );
      context.loaderOverlay.hide();
      Get.offAllNamed("/");
      return;
    }

    Get.snackbar(
        "Success!", "Your submission was successful! Heroes are on their way!",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        isDismissible: true,
        backgroundColor: Colors.green);

    // generate marker id
    String randomID = generateRandomString(10);

    // upload image to firebase and get its url
    final FirebaseRepository _fbRepo = Get.find();
    String imageURL = await _fbRepo.uploadImageToStorage(_selectedFile!);

    MarkerModel markerModel = MarkerModel(
      id: randomID,
      category: geminiResponse.emoji,
      complexity: geminiResponse.complexity,
      description: geminiResponse.summary,
      imageURL: imageURL,
      title: geminiResponse.title,
      location: GeoPoint(location.latitude, location.longitude),
      reward: geminiResponse.complexity! * 100,
    );

    // add marker to firestore
    await _fbRepo.addMarker(markerModel);

    context.loaderOverlay.hide();
    // navigate to /home page and trigger reload
    Get.offAllNamed("/");
  }

  @override
  void onClose() {
    print("Closed claim screen");
    final HomeScreenController homeScreenController = Get.find();
    homeScreenController.clean();

    super.onClose();
  }
}
