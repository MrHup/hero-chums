import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/screens/screen_base_template.dart';
import 'package:hero_chum/static/auth.dart';
import 'package:hero_chum/static/constants.dart';
import 'package:rive/rive.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Widget leftHandside(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Expanded(
      flex: 1,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.width * 0.4
                      : MediaQuery.of(context).size.width * 0.8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Let's get you set up!",
                  style: smallHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: const Color(0x3baab0f3),
                    hintText: 'Email',
                    hintStyle: hintTextStyle,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: const Color(0x3baab0f3),
                    hintText: 'Password',
                    hintStyle: hintTextStyle,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    registerUser(
                        _emailController.text, _passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    textStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Rounded corners
                    ),
                    minimumSize: const Size(double.infinity, 70), // Button size
                  ),
                  child:
                      const Text('SignUp now!', style: highlighButtonTextStyle),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: const Text('Already have an account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget righHandside() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Expanded(
              child: RiveAnimation.asset(
                'assets/animations/herochums.riv',
              ),
            ),
            Expanded(child: Image.asset('assets/images/login_motto.png')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBaseTemplate(
      child: MediaQuery.of(context).orientation == Orientation.landscape
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [leftHandside(context), righHandside()],
            )
          : Column(
              children: [leftHandside(context), righHandside()],
            ),
    );
  }
}
