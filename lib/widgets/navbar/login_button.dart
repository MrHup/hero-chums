import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/screens/login_screen.dart';
import 'package:hero_chum/static/constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        Get.to(const LoginScreen(), transition: Transition.fadeIn);
      },
      child: const Text(
        "Login",
        style: buttonTextStyle,
      ),
    );
  }
}
