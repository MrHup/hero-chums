import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';

class MapButton extends StatelessWidget {
  const MapButton({super.key});

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
        "Map",
        style: buttonTextStyle,
      ),
    );
  }
}
