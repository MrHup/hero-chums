import 'package:get/get.dart';
import 'package:hero_chum/models/reward.dart';
import 'package:hero_chum/static/firebase_repo.dart';

class RewardsScreenController extends GetxController {
  Future<List<RewardModel>> getRewards() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.put(FirebaseRepository());
    final FirebaseRepository fbRepo = Get.find();
    List<RewardModel> rewardsDataList = await fbRepo.fetchAllRewards();

    return rewardsDataList;
  }

  Future<void> redeemReward(RewardModel reward) async {
    final FirebaseRepository fbRepo = Get.find();
    await fbRepo.addRewardClaim(reward);
  }
}
