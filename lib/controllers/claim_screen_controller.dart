import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html;

class ClaimScreenController extends GetxController {
  PlatformFile? _selectedFile;

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
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
    }
  }
}
