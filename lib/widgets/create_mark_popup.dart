import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/coordinates_label.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/map_preview.dart';
import 'package:hero_chum/widgets/task_description_field.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CreateMarkPopup extends StatelessWidget {
  const CreateMarkPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final widthFactor = isLandscape ? 0.33 : 1.0;

    return Obx(() => GlobalState.isMarkerOpen.value
        ? Center(
            child: Align(
              alignment:
                  isLandscape ? Alignment.centerRight : Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: widthFactor,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Create Task",
                              style: smallHeaderTextStyle),
                          CoordinatesLabel(
                              latitude:
                                  GlobalState.currentMarker.value.latitude,
                              longitude:
                                  GlobalState.currentMarker.value.longitude),
                          CircularMapPreview(),
                          // Expanded(child: SimpleMarkerAnimationExample()),
                          const SizedBox(height: 8),
                          ImageUploadButton(onPressed: () {
                            GlobalState.isMapBlocked.value = true;
                            context.loaderOverlay.show();
                          }),
                          const SizedBox(height: 8),
                          TaskDescriptionField(
                              controller: TextEditingController()),
                          const SizedBox(height: 8),
                          // UrgencySelector(),
                          const SizedBox(height: 8),
                          GradientSubmitButton(onPressed: () async {
                            // await textGen();
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container());
  }
}
