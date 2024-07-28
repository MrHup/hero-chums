import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/controllers/claim_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';

class ClaimScreen extends GetView<ClaimScreenController> {
  const ClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarkerModel? marker = Get.arguments;

    if (marker == null) {
      return const Scaffold(
          body: Center(
        child: Text("Something went wrong"),
      ));
    }

    return Scaffold(
        appBar:
            const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
        drawer: const LeftDrawer(),
        body: Column(
          children: [_getInfoCard(marker)],
        ));
  }

  Widget _getInfoCard(MarkerModel mark) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text(
                mark.category!,
                style: const TextStyle(fontSize: 25, fontFamily: "Emoji"),
              ),
              Text(
                mark.title!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: mark.imageURL!,
                  width: 400,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/avatars/a1.png"),
                ),
              ),
            ],
          ),
          _getTextGraphicPair(
              "Reward:", mark.reward!.toString(), "assets/images/rubies.png"),
          _getTextGraphicPair("Complexity:", mark.complexity!.toString(),
              "assets/images/watches.png"),
          const SizedBox(height: 20),
          GradientSubmitButton(onPressed: () {})
        ]),
      ),
    );
  }

  Widget _getTextGraphicPair(String text1, String text2, String imgPath) {
    return Row(
      children: [
        Text(text1,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(text2, style: const TextStyle(fontSize: 16)),
        Image.asset(imgPath, width: 40, height: 20)
      ],
    );
  }
}
