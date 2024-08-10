import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LandingPageHeader extends StatelessWidget {
  LandingPageHeader({required this.child, super.key});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(Get.context!).size.width * 0.6
                : MediaQuery.of(Get.context!).size.width * 0.85,
            child: child),
      ),
    );
  }
}
