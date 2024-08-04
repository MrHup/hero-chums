import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';

class MapButton extends StatelessWidget {
  const MapButton({this.forNavBar = false, super.key});

  final bool forNavBar;

  void _onPressed() {
    Get.toNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return !forNavBar
        ? TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: _onPressed,
            child: const Text(
              "Map",
              style: buttonTextStyle,
            ),
          )
        : ListTile(
            onTap: _onPressed,
            leading: const Icon(Icons.map),
            title: const Text("Map"),
          );
  }
}
