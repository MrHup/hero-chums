import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hero_chum/widgets/navbar/about_us_button.dart';
import 'package:hero_chum/widgets/navbar/register_button.dart';
import 'package:hero_chum/widgets/navbar/map_button.dart';
import 'package:hero_chum/widgets/navbar/rewards_button.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.offNamedUntil("/", ModalRoute.withName('/'));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Image.asset('assets/images/logo_text.png'),
              ),
            ),
            MediaQuery.of(context).orientation == Orientation.landscape
                ? const Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MapButton(),
                              AboutUsButton(),
                              RewardsButton(),
                            ],
                          ),
                          RegisterButton()
                        ]),
                  )
                : Row(
                    children: [
                      const RegisterButton(),
                      IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(CupertinoIcons.line_horizontal_3)),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
