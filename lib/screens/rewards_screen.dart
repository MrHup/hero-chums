import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_chum/controllers/rewards_screen_controller.dart';
import 'package:hero_chum/models/reward.dart';
import 'package:hero_chum/static/state.dart';
import 'package:hero_chum/widgets/navbar/left_drawer.dart';
import 'package:hero_chum/widgets/navbar/navbar.dart';
import 'package:rive/rive.dart';

class RewardsScreen extends GetView<RewardsScreenController> {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<List<RewardModel>> _firebaseRewards = controller.getRewards();

    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(50, 100), child: NavBar()),
      body: FutureBuilder<List<RewardModel>>(
        future: _firebaseRewards,
        builder:
            (BuildContext context, AsyncSnapshot<List<RewardModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: RiveAnimation.asset(
                      'assets/animations/rewards_chum.riv',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Loading...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final rewards = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 5
                      : 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.7, // Adjust aspect ratio for card size
            ),
            itemCount: rewards.length,
            itemBuilder: (BuildContext context, int index) {
              final reward = rewards[index];
              return Card(
                surfaceTintColor: Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        reward.title ?? 'No Title',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: reward.imageURL != null
                          ? Image.network(
                              reward.imageURL!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (GlobalState.isUserLoggedIn.value == false) {
                            Get.snackbar(
                              "Account Required",
                              "Create an account in order to redeem a prize",
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(16),
                              isDismissible: true,
                              backgroundColor: Colors.amber,
                            );
                            return;
                          }
                          if (GlobalState.gems.value < reward.cost!) {
                            Get.snackbar(
                              "Insufficient Gems",
                              "You need more gems to redeem this prize",
                              snackPosition: SnackPosition.BOTTOM,
                              margin: const EdgeInsets.all(16),
                              isDismissible: true,
                              backgroundColor: Colors.redAccent,
                            );
                            return;
                          }

                          await controller.redeemReward(reward);
                          Get.snackbar(
                            "Success!",
                            "You will be contacted via email regarding the prize shortly",
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(16),
                            isDismissible: true,
                            backgroundColor: Colors.greenAccent,
                          );
                        },
                        child: Text('${reward.cost ?? 0} points'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      drawer: const LeftDrawer(),
    );
  }
}
