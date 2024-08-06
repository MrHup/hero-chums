import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hero_chum/models/marker.dart';
import 'package:hero_chum/models/reward.dart';
import 'package:hero_chum/models/reward_claim.dart';
import 'package:hero_chum/static/state.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MarkerModel>> fetchAllMarkers(
      {String docName = "markers"}) async {
    final markersListDoc =
        await _firestore.collection("markers").doc(docName).get();
    if (markersListDoc.exists) {
      print("Exists!!");
      final List<dynamic> markersDataList = markersListDoc.data()!["markers"];
      return markersDataList
          .map((markerData) => MarkerModel.fromJson(markerData))
          .toList();
    }
    return [];
  }

  Future<List<RewardModel>> fetchAllRewards(
      {String docName = "rewards"}) async {
    final rewardsListDoc =
        await _firestore.collection("rewards").doc(docName).get();

    if (rewardsListDoc.exists) {
      final List<dynamic> rewardsDataList = rewardsListDoc.data()!["rewards"];
      return rewardsDataList
          .map((rewardData) => RewardModel.fromJson(rewardData))
          .toList();
    }
    return [];
  }

  Future<void> addRewardClaim(RewardModel reward) async {
    RewardClaimModel rewardClaim = RewardClaimModel(
      cost: reward.cost,
      prizeName: reward.title,
      userID: GlobalState.user!.uid,
    );
    await _firestore.collection("rewards").doc("claims").update({
      "claims": FieldValue.arrayUnion([rewardClaim.toJson()])
    });
  }

  Future<String> uploadImageToStorage(PlatformFile file) async {
    try {
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('events/${DateTime.now().toIso8601String()}.${file.extension}')
          .putData(
            file.bytes!,
            SettableMetadata(contentType: 'image/${file.extension}'),
          );

      String url = await upload.ref.getDownloadURL();
      print("Image uploaded with success, yay! $url");

      return url;
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
    }
    return "https://icons.veryicon.com/png/System/Small%20%26%20Flat/sign%20error.png";
  }

  Future<void> addMarker(MarkerModel marker) async {
    await _firestore.collection("markers").doc("markers").update({
      "markers": FieldValue.arrayUnion([marker.toJson()])
    });
  }
}
