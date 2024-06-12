import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';

class AboutUsButton extends StatelessWidget {
  const AboutUsButton({this.forNavBar = false, super.key});

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
              "About Us",
              style: buttonTextStyle,
            ),
          )
        : ListTile(
            onTap: _onPressed,
            leading: const Icon(Icons.sentiment_satisfied_rounded),
            title: const Text("About Us"),
          );
  }
}
