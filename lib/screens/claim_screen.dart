import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/claim_screen_controller.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/screens/something_went_wrong.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/map_preview_fixed.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rive/rive.dart';

class ClaimScreen extends GetView<ClaimScreenController> {
  const ClaimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MarkerModel? marker = Get.arguments;
    controller.marker = marker;

    if (marker == null) {
      return const SomethingWentWrong();
    }

    final children = [_getInfoCard(marker), _getActionColumn(marker, context)];

    return Scaffold(
        appBar:
            const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
        drawer: const LeftDrawer(),
        body: LoaderOverlay(
          overlayWholeScreen: true,
          overlayColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 350,
                child: RiveAnimation.asset(
                  'assets/animations/herochums.riv',
                ),
              ),
              SizedBox(height: 20),
              Text("Loading...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          )),
          child: MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: children)
              : ListView(children: children),
        ));
  }

  Widget _getActionColumn(MarkerModel mark, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FixedMapPreview(
            mark: LatLng(mark.location!.latitude, mark.location!.longitude),
          ),
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
          Obx(() => controller.imageUrl.value.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(controller.imageUrl.value, width: 200),
                )),
          const SizedBox(height: 8),
          SizedBox(
              width: 500,
              child: GradientSubmitButton(onPressed: () async {
                await controller.submitClaim(context);
              }))
        ],
      ),
    );
  }

  Widget _getInfoCard(MarkerModel mark) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              child:
                                  Image.asset("assets/images/avatars/a1.png"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getTextGraphicPair(
                                "Reward:",
                                mark.reward!.toString(),
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
                          ],
                        ),
                      ),
                    ]),
              ),
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
