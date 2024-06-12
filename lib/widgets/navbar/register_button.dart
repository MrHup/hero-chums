import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/static/state.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  Widget _getStartNowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed("/register");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Background color
          textStyle: const TextStyle(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          minimumSize: const Size(100, 50), // Button size
        ),
        child: const Text('Start Now', style: highlighButtonTextStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !GlobalState.isUserLoggedIn.value
        ? _getStartNowButton()
        : IconButton(
            onPressed: () {
              Get.toNamed("/user");
            },
            icon: Image.asset("assets/images/avatars/a1.png")));
  }
}
