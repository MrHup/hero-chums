import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/coordinates_label.dart';
import 'package:hero_chum/widgets/gradient_submit_button.dart';
import 'package:hero_chum/widgets/image_upload_button.dart';
import 'package:hero_chum/widgets/task_description_field.dart';
import 'package:hero_chum/widgets/urgency_selector.dart';

class CreateMarkPopup extends StatelessWidget {
  const CreateMarkPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final widthFactor = isLandscape ? 0.33 : 0.85;

    return Obx(() => GlobalState.isMarkerOpen.value
        ? Center(
            child: Align(
              alignment: isLandscape ? Alignment.centerRight : Alignment.center,
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
                          const SizedBox(height: 8),
                          ImageUploadButton(
                              onPressed: () {/* Handle upload */}),
                          const SizedBox(height: 8),
                          TaskDescriptionField(
                              controller: TextEditingController()),
                          const SizedBox(height: 8),
                          // UrgencySelector(),
                          const SizedBox(height: 8),
                          GradientSubmitButton(
                              onPressed: () {/* Handle submit */}),
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
