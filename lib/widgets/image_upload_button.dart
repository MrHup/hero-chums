import 'package:flutter/material.dart';
import 'package:hero_chum/static/constants.dart';

class ImageUploadButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ImageUploadButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Photo of request", style: hintTextStyle),
        ElevatedButton.icon(
          icon: const Icon(Icons.upload_file, color: Colors.white),
          label:
              const Text("Upload Photo", style: TextStyle(color: Colors.white)),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: ourBlue,
            minimumSize: const Size(double.infinity, 70),
          ),
        ),
      ],
    );
  }
}
