import 'package:flutter/material.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/navbar/about_us_button.dart';
import 'package:hero_chum/widgets/navbar/map_button.dart';
import 'package:hero_chum/widgets/navbar/register_button.dart';
import 'package:hero_chum/widgets/navbar/rewards_button.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              const RewardsButton(forNavBar: true)
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
    );
  }
}
