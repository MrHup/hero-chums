import 'package:flutter/material.dart';

class ImageUploadButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ImageUploadButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.upload_file, color: Colors.white),
      label: const Text("Upload Photo", style: TextStyle(color: Colors.white)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.grey,
        minimumSize: const Size(double.infinity, 80),
      ),
    );
  }
}
