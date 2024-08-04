import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hero_chum/controllers/home_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/state.dart';
import 'dart:html' as html;

import 'package:loader_overlay/loader_overlay.dart';

class ClaimScreenController extends GetxController {
  PlatformFile? _selectedFile;
  MarkerModel? marker;
  RxString imageUrl = "".obs;

  void uploadImage() async {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null) {
      print(picked.files.first.name);
      _selectedFile = picked.files.first;
      final bytes = _selectedFile!.bytes;
      if (bytes != null) {
        final blob = html.Blob([Uint8List.fromList(bytes)]);
        imageUrl.value = html.Url.createObjectUrlFromBlob(blob);
      }
    }
  }

  Future<void> submitClaim(BuildContext context) async {
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
      print("Account required");
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

    try {
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref(
              'events/${DateTime.now().toIso8601String()}.${_selectedFile!.extension}')
          .putData(
            _selectedFile!.bytes!,
            SettableMetadata(contentType: 'image/${_selectedFile!.extension}'),
          );

      String url = await upload.ref.getDownloadURL();
      print("Image uploaded with success, yay! $url");

      await FirebaseFirestore.instance.collection('claims').add({
        "imageURL": url,
        "userID": GlobalState.user!.uid,
        "timestamp": DateTime.now().toIso8601String(),
        "markerID": marker!.id,
      });
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
    }

    context.loaderOverlay.hide();
  }

  @override
  void onClose() {
    print("Closed claim screen");
    final HomeScreenController homeScreenController = Get.find();
    homeScreenController.clean();

    super.onClose();
  }
}
