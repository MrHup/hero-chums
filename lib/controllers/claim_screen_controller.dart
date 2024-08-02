import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hero_chum/controllers/home_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/static/state.dart';

class ClaimScreenController extends GetxController {
  PlatformFile? _selectedFile;
  MarkerModel? marker;

  void uploadImage() async {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null) {
      print(picked.files.first.name);
      _selectedFile = picked.files.first;
    }
  }

  Future<void> submitClaim() async {
    if (_selectedFile == null) {
      print('No file to upload.');
      return;
    }

    if (GlobalState.isUserLoggedIn.value == false) {
      Get.toNamed("/register");
      return;
    }

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
  }

  @override
  void onClose() {
    print("Closed claim screen");
    final HomeScreenController homeScreenController = Get.find();
    homeScreenController.clean();

    super.onClose();
  }
}
