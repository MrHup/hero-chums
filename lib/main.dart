import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:hero_chum/controllers/home_screen_controller.dart';
import 'package:hero_chum/controllers/rewards_screen_controller.dart';
import 'package:hero_chum/screens/about_us_screen.dart';
import 'package:hero_chum/screens/claim_screen.dart';
import 'package:hero_chum/screens/create_screen.dart';
import 'package:hero_chum/screens/home_screen.dart';
import 'package:hero_chum/screens/login_screen.dart';
import 'package:hero_chum/screens/register_screen.dart';
import 'package:hero_chum/screens/rewards_screen.dart';
import 'package:hero_chum/screens/unknown_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hero_chum/screens/user_screen.dart';
import 'package:hero_chum/static/state.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: dotenv.env['GEN_AI_KEY']!, enableDebugging: true);
  WidgetsFlutterBinding.ensureInitialized();
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
    initialBinding: BindingsBuilder(() {
      Get.put(HomeScreenController());
      Get.put(RewardsScreenController());
    }),
    getPages: [
      GetPage(
          name: '/',
          page: () => const HomeScreen(),
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
      GetPage(
          name: '/claim',
          page: () => const ClaimScreen(),
          transition: Transition.downToUp),
      GetPage(
          name: '/create',
          page: () => const CreateScreen(),
          transition: Transition.downToUp),
      GetPage(
          name: '/rewards',
          page: () => const RewardsScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: '/about',
          page: () => const AboutUsScreen(),
          transition: Transition.fadeIn),
    ],
  ));
}
