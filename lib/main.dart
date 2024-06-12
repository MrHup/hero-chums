import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/screens/login_screen.dart';
import 'package:hero_chum/screens/map_screen.dart';
import 'package:hero_chum/screens/register_screen.dart';
import 'package:hero_chum/screens/unknown_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hero_chum/screens/user_screen.dart';
import 'package:hero_chum/static/state.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      GlobalState.isUserLoggedIn.value = true;
      GlobalState.user = user;
    }
  });

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
          name: '/map',
          page: () => const MapScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: '/user',
          page: () => const UserScreen(),
          transition: Transition.fadeIn),
    ],
  ));
}
