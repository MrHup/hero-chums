import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hero_chum/controllers/create_screen_controller.dart';
import 'package:hero_chum/screens/something_went_wrong.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/widgets/coordinates_label.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/map_preview_fixed.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:hero_chum/widgets/task_description_field.dart';

// ignore: must_be_immutable
class CreateScreen extends GetView<CreateScreenController> {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LatLng? location = Get.arguments;
    if (location == null) {
      return const SomethingWentWrong();
    }

    return Scaffold(
        appBar:
            const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
        drawer: const LeftDrawer(),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              shadowColor: Colors.white,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                        child:
                            Text("Create Task", style: smallHeaderTextStyle)),
                    Center(
                      child: CoordinatesLabel(
                          latitude: location.latitude,
                          longitude: location.longitude),
                    ),
                    Center(child: FixedMapPreview(mark: location)),
                    // Expanded(child: SimpleMarkerAnimationExample()),
                    const SizedBox(height: 8),
                    ImageUploadButton(onPressed: controller.uploadImage),
                    Obx(() => controller.imageUrl.value.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.network(controller.imageUrl.value),
                          )),
                    const SizedBox(height: 8),
                    // add image here
                    TaskDescriptionField(controller: TextEditingController()),
                    const SizedBox(height: 8),
                    // UrgencySelector(),
                    const SizedBox(height: 8),
                    GradientSubmitButton(onPressed: () async {
                      await controller.submit(location);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
