import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';

class AboutUsButton extends StatelessWidget {
  const AboutUsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        Get.toNamed("/map");
      },
      child: const Text(
        "About Us",
        style: buttonTextStyle,
      ),
    );
  }
}
