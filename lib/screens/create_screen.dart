import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/create_screen_controller.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/widgets/coordinates_label.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/map_preview_fixed.dart';
import 'package:hero_chum/widgets/task_description_field.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class CreateScreen extends GetView<CreateScreenController> {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng? location = Get.arguments;
    if (location == null) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Create Task", style: smallHeaderTextStyle),
        CoordinatesLabel(
            latitude: location.latitude, longitude: location.longitude),
        FixedMapPreview(mark: location),
        // Expanded(child: SimpleMarkerAnimationExample()),
        const SizedBox(height: 8),
        ImageUploadButton(onPressed: () {}),
        const SizedBox(height: 8),
        TaskDescriptionField(controller: TextEditingController()),
        const SizedBox(height: 8),
        // UrgencySelector(),
        const SizedBox(height: 8),
        GradientSubmitButton(onPressed: () async {
          // await textGen();
        }),
      ],
    );
  }
}
