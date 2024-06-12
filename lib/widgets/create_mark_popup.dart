import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hero_chum/static/state.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(

                        // This Child Container can be filled with any desired widgets.
                        ),
                  ),
                ),
              ),
            ),
          )
        : Container());
  }
}
