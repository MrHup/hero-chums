import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/screens/map_screen.dart';
import 'package:hero_chum/screens/unknown_screen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    unknownRoute: GetPage(name: '/notfound', page: () => UnknownScreen()),
    initialRoute: '/',
    getPages: [
      GetPage(
          name: '/', page: () => MapScreen(), transition: Transition.native),
    ],
  ));
}
