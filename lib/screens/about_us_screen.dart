import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/controllers/rewards_screen_controller.dart';
import 'package:hero_chum/widgets/landing_page_header.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:rive/rive.dart';

class AboutUsScreen extends GetView<RewardsScreenController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
      body: Center(
        child: ListView(
          children: [
            LandingPageHeader(child: _getHeroCard(context)),
            LandingPageHeader(child: const Divider()),
            LandingPageHeader(child: _get2ndCard(context)),
            LandingPageHeader(child: const Divider()),
            LandingPageHeader(child: _get3rdCard(context)),
            LandingPageHeader(child: const Divider()),
            LandingPageHeader(child: _get4thCard(context)),
          ],
        ),
      ),
      drawer: const LeftDrawer(),
    );
  }

  Widget _getTitle(String text) {
    return MediaQuery.of(Get.context!).orientation == Orientation.landscape
        ? Text(text,
            style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xff06092b)))
        : Center(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff06092b))),
          );
  }

  Widget _getHeroCard(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? Row(children: _getHeroChildrenCard(context))
        : Column(children: _getHeroChildrenCard(context));
  }

  List<Widget> _getHeroChildrenCard(BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle("Be a HERO"),
          SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(Get.context!).size.width * 0.3
                : MediaQuery.of(Get.context!).size.width * 0.85,
            child: Text(
              "EchoHero is an open source PoC platform for public good built for the Gemini API Developer Competition. It allows users to signal issues in their city and offers points to those who resolve them, all that while using Gemini's AI to moderate and control the user content.",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 350,
        height: 350,
        child: RiveAnimation.asset(
          'assets/animations/herochums.riv',
        ),
      ),
    ];
  }

  Widget _get2ndCard(BuildContext context) {
    String text =
        "Taking a look around your city, you will see many things that can be improved. However you don't always have the time or capacity to address them. But someone out there might. We aim to connect these people and encourage the local community in making they city that they love, better.";
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              width: 350,
              height: 350,
              child: RiveAnimation.asset(
                'assets/animations/why.riv',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _getTitle("Why?"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(Get.context!).size.width * 0.3
                        : MediaQuery.of(Get.context!).size.width * 0.85,
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ])
        : Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _getTitle("Why?"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(Get.context!).size.width * 0.3
                        : MediaQuery.of(Get.context!).size.width * 0.85,
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 350,
              height: 350,
              child: RiveAnimation.asset(
                'assets/animations/why.riv',
              ),
            ),
          ]);
  }

  Widget _get3rdCard(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? Row(children: _get3rdChildrenCard(context))
        : Column(children: _get3rdChildrenCard(context));
  }

  List<Widget> _get3rdChildrenCard(BuildContext context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle("How?"),
          SizedBox(
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(Get.context!).size.width * 0.3
                : MediaQuery.of(Get.context!).size.width * 0.85,
            child: Text(
              "This project was crafted solo in just a few weeks using Flutter, with a little help from Gemini's API. We used Firebase as the BaaS of choice and integrated with the Google Maps SDK.",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: 350,
        height: 350,
        child: Image.asset("assets/images/tech_stack.png"),
      ),
    ];
  }

  Widget _get4thCard(BuildContext context) {
    String text =
        "As of writing this, the platform has been deployed only on web. A mobile version exists and can be found under the 'mobile' branch on GitHub. As this is simply a proof of concept, if the platform proves viable, a mobile application will soon be on its way.";
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              width: 350,
              height: 350,
              child: Image.asset("assets/images/coming_soon.png"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _getTitle("Mobile Support"),
                SizedBox(
                  width: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(Get.context!).size.width * 0.3
                      : MediaQuery.of(Get.context!).size.width * 0.85,
                  child: Text(
                    text,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ])
        : Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _getTitle("Mobile Support"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(Get.context!).size.width * 0.3
                        : MediaQuery.of(Get.context!).size.width * 0.85,
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 350,
              height: 350,
              child: Image.asset("assets/images/coming_soon.png"),
            ),
          ]);
  }
}
