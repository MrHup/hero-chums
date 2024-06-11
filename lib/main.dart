import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/screens/login_screen.dart';
import 'package:hero_chum/screens/map_screen.dart';
import 'package:hero_chum/screens/unknown_screen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    unknownRoute: GetPage(name: '/notfound', page: () => const UnknownScreen()),
    initialRoute: '/',
    getPages: [
      GetPage(
          name: '/',
          page: () => const MapScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: '/LoginScreen',
          page: () => const LoginScreen(),
          transition: Transition.fadeIn),
    ],
  ));
}
