import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/controllers/claim_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/map_preview_fixed.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:rive/rive.dart';

class ClaimScreen extends GetView<ClaimScreenController> {
  const ClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarkerModel? marker = Get.arguments;

    if (marker == null) {
      return const Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 350,
              child: RiveAnimation.asset(
                'assets/animations/sad_square_idle.riv',
              ),
            ),
            SizedBox(height: 20),
            Text("Something went wrong",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ));
    }

    final children = [_getInfoCard(marker), _getActionColumn(marker)];

    return Scaffold(
        appBar:
            const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
        drawer: const LeftDrawer(),
        body: MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children)
            : ListView(children: children));
  }

  Widget _getActionColumn(MarkerModel mark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FixedMapPreview(mark: mark),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
                "To mark the job as complete, provide an image of the completed task",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(174, 43, 43, 43),
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
              width: 500,
              child: ImageUploadButton(onPressed: controller.uploadImage)),
          const SizedBox(height: 8),
          SizedBox(
              width: 500,
              child: GradientSubmitButton(onPressed: controller.submitClaim))
        ],
      ),
    );
  }

  Widget _getInfoCard(MarkerModel mark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: IntrinsicHeight(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          mark.category!,
                          style: const TextStyle(
                              fontSize: 25, fontFamily: "Emoji"),
                        ),
                        Text(
                          mark.title!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                        SizedBox(
                          width: 400,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Image.asset("assets/images/avatars/a1.png"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _getTextGraphicPair("Reward:", mark.reward!.toString(),
                        "assets/images/rubies.png"),
                    _getTextGraphicPair(
                        "Complexity:",
                        _getSpecificString(mark.complexity!),
                        "assets/images/watches.png"),
                    const Text("Description:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 420,
                      height: 75,
                      child: Text(mark.description!,
                          maxLines: 5,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(174, 43, 43, 43),
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  String _getSpecificString(int complexity) {
    if (complexity == 1) {
      return "Simple";
    } else if (complexity == 2) {
      return "Average";
    } else if (complexity == 3) {
      return "Difficult";
    }

    return "Normal";
  }

  Widget _getTextGraphicPair(String text1, String text2, String imgPath) {
    return Row(
      children: [
        Text(text1,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(text2,
            style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(174, 43, 43, 43),
                fontWeight: FontWeight.bold)),
        Image.asset(imgPath, width: 40, height: 20)
      ],
    );
  }
}
