import 'package:flutter/material.dart';
import 'package:hero_chum/widgets/map_widget.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          NavBar(),
          Expanded(child: MapSample()),
        ],
      ),
    );
  }
}
