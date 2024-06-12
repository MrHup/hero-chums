import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/auth.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!GlobalState.isUserLoggedIn.value) {
      Get.toNamed('/');
    }
    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      signOutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      textStyle: const TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      minimumSize:
                          const Size(double.infinity, 70), // Button size
                    ),
                    child: const Text('Logout', style: highlighButtonTextStyle),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
