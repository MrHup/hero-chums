import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/constants.dart';

class RewardsButton extends StatelessWidget {
  const RewardsButton({this.forNavBar = false, super.key});

  final bool forNavBar;

  void _onPressed() {
    Get.toNamed("/rewards");
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
              "Rewards",
              style: buttonTextStyle,
            ),
          )
        : ListTile(
            onTap: _onPressed,
            leading: const Icon(Icons.redeem),
            title: const Text("Rewards"),
          );
  }
}
