import 'package:flutter/material.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/navbar/about_us_button.dart';
import 'package:hero_chum/widgets/navbar/map_button.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:hero_chum/widgets/navbar/register_button.dart';

class ScreenBaseTemplate extends StatelessWidget {
  const ScreenBaseTemplate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [const NavBar(), Expanded(child: child)],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                DrawerHeader(
                    child: GlobalState.isUserLoggedIn.value
                        ? Column(
                            children: [
                              Image.asset("assets/images/avatars/a1.png"),
                              // Text(GlobalState.user.value.username)
                            ],
                          )
                        : Image.asset("assets/images/logo.png")),
                const MapButton(forNavBar: true),
                const AboutUsButton(forNavBar: true),
              ],
            ),
            !GlobalState.isUserLoggedIn.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RegisterButton(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
