import 'package:flutter/material.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:rive/rive.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's get you set up!",
                        style: smallHeaderTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: RiveAnimation.asset(
                            'assets/animations/herochums.riv',
                          ),
                        ),
                        Image.asset('assets/images/login_motto.png'),
                      ],
                    ),
                  ),
                )
                // const Expanded(
                //   child: RiveAnimation.asset(
                //     'assets/animations/herochums.riv',
                //   ),
                // ),
                // Expanded(
                //   child: Image.asset('assets/images/login_motto.png'),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
