import 'package:flutter/material.dart';
import 'package:hero_chum/screens/screen_base_template.dart';
import 'package:hero_chum/widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBaseTemplate(child: MapSample());
  }
}
